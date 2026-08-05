import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harbor/widgets/app_icon.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';
import '../../focus/focusable_action_bar.dart';
import '../../focus/input_mode_tracker.dart';
import '../../mixins/tab_navigation_mixin.dart';
import '../../media/media_item.dart';
import '../../media/media_library.dart';
import '../../providers/hidden_libraries_provider.dart';
import '../../providers/libraries_provider.dart';
import '../../services/settings_service.dart';
import '../../widgets/settings_builder.dart';
import '../../utils/app_logger.dart';
import '../../utils/platform_detector.dart';
import '../../utils/content_utils.dart';
import '../../widgets/overlay_sheet.dart';
import 'library_quick_picker_sheet.dart';
import '../../widgets/backend_badge.dart';
import '../../widgets/desktop_app_bar.dart';
import '../../widgets/library_management_sheet.dart';
import '../../services/storage_service.dart';
import '../../mixins/refreshable.dart';
import '../../mixins/item_updatable.dart';
import '../../i18n/strings.g.dart';
import 'state_messages.dart';
import 'tabs/library_browse_tab.dart';
import '../../providers/managed_services_provider.dart';
import '../../media/library_view.dart';
import 'library_selection.dart';
import 'tabs/library_missing_tab.dart';

enum LibraryTabType { browse, missing }

/// Which libraries have an *arr that can answer for their kind, and so can offer
/// their gap alongside their contents.
Set<String> _librariesOfferingMissing(List<MediaLibrary> libraries, ManagedServicesProvider services) {
  return {
    for (final library in libraries)
      if (LibraryMissingTab.kindFor(library.kind) case final kind?)
        if (services.of(kind).isNotEmpty) library.globalKey,
  };
}

class LibrariesScreen extends StatefulWidget {
  final VoidCallback? onLibraryOrderChanged;
  final ValueChanged<String>? onLibrarySelected;

  const LibrariesScreen({super.key, this.onLibraryOrderChanged, this.onLibrarySelected});

  @override
  State<LibrariesScreen> createState() => _LibrariesScreenState();
}

class _LibrariesScreenState extends State<LibrariesScreen>
    with
        Refreshable,
        FullRefreshable,
        FocusableTab,
        LibraryLoadable,
        ItemUpdatable,
        TickerProviderStateMixin,
        TabNavigationMixin {
  // GlobalKeys for tabs to enable refresh
  final _browseTabKey = GlobalKey();

  String? _errorMessage;
  String? _selectedLibraryGlobalKey;
  bool _isInitialLoad = true;

  /// Flag to prevent onTabChanged from focusing when we're programmatically changing tabs

  /// Track which tabs have loaded data (used to trigger focus after tab restore)
  final Set<int> _loadedTabs = {};

  /// Whether the browse tab has active filters (badges the Library options icon)
  bool _browseFiltersActive = false;

  /// Key for the library dropdown menu button.

  // Dynamic visible tabs and their focus nodes
  /// Fixed at one. The screen shows a single thing and the selector chooses it,
  /// so nothing about the tab controller varies at runtime any more.
  static const List<LibraryTabType> _visibleTabs = [LibraryTabType.browse];

  LibrarySelection? _selection;
  List<LibraryView> _views = const [];
  Set<String> _librariesWithMissing = const {};
  // The mixin still wants a node per tab, and there is exactly one.
  final List<FocusNode> _tabFocusNodes = [FocusNode(debugLabel: 'library_body')];

  @override
  List<FocusNode> get tabChipFocusNodes => _tabFocusNodes;

  final _actionBarKey = GlobalKey<FocusableActionBarState>();

  final ScrollController _outerScrollController = ScrollController();

  /// Reveal the floating header by jumping the outer NestedScrollView back
  /// to offset 0. The outer position is preserved across content changes
  /// (library switch, library reload, filter/sort change), so any time the
  /// inner is reset to the top we must explicitly resync the outer — the
  /// natural delta-surrender coordination only fires on user scroll gestures.
  ///
  /// Iterates `positions` rather than reading `offset` because the controller
  /// is shared between the simple CustomScrollView (loading/empty/error) and
  /// the NestedScrollView (selected library), and during the transition both
  /// can briefly be attached — `offset` would throw on `_positions.single`.
  void _resetOuterScroll() {
    if (!_outerScrollController.hasClients) return;
    for (final position in _outerScrollController.positions) {
      if (position.pixels > 0) {
        position.jumpTo(0);
      }
    }
  }

  /// Override the mixin's [focusTabBar] so we reveal the floating header
  /// (which contains the tab chips) before requesting focus. Programmatic
  /// requestFocus alone does not snap a floating SliverAppBar back into view.
  @override
  void focusTabBar() {
    _resetOuterScroll();
    super.focusTabBar();
  }

  @override
  void initState() {
    super.initState();
    initTabNavigation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _services = context.read<ManagedServicesProvider>()..addListener(_recomputeMissingAvailability);
      _initializeWithLibraries();
    });
  }

  ManagedServicesProvider? _services;

  /// The tab row is computed when a library loads, but the connections it asks
  /// about are restored from storage a moment later — so on a cold start the
  /// Missing tab was decided against before its instance existed, and nothing
  /// asked again.
  bool _sameViews(List<LibraryView> a, List<LibraryView> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].name != b[i].name) return false;
    }
    return true;
  }

  /// The connections the selector asks about are restored from storage after the
  /// screen is built, so what it can offer has to be recomputed when they land.
  void _recomputeMissingAvailability() {
    if (!mounted) return;
    final services = _services;
    if (services == null) return;
    final offering = _librariesOfferingMissing(context.read<LibrariesProvider>().libraries, services);
    if (setEquals(offering, _librariesWithMissing)) return;
    setState(() => _librariesWithMissing = offering);
  }

  /// Initialize the screen with libraries from the provider.
  /// This handles initial library selection and content loading.
  Future<void> _initializeWithLibraries() async {
    final librariesProvider = context.read<LibrariesProvider>();
    final hiddenLibrariesProvider = context.read<HiddenLibrariesProvider>();
    await hiddenLibrariesProvider.ensureInitialized();
    final allLibraries = librariesProvider.libraries;

    if (allLibraries.isEmpty) {
      return;
    }

    // Compute visible libraries for initial load
    final hiddenKeys = hiddenLibrariesProvider.hiddenLibraryKeys;
    final visibleLibraries = allLibraries.where((lib) => !hiddenKeys.contains(lib.globalKey)).toList();

    final storage = await StorageService.getInstance();
    final savedLibraryKey = storage.getSelectedLibraryKey();

    // Find the library by key in visible libraries
    String? libraryGlobalKeyToLoad;
    if (savedLibraryKey != null) {
      final libraryExists = visibleLibraries.any((lib) => lib.globalKey == savedLibraryKey);
      if (libraryExists) {
        libraryGlobalKeyToLoad = savedLibraryKey;
      }
    }

    // Fallback to first visible library if saved key not found
    if (libraryGlobalKeyToLoad == null && visibleLibraries.isNotEmpty) {
      libraryGlobalKeyToLoad = visibleLibraries.first.globalKey;
    }

    if (libraryGlobalKeyToLoad != null && mounted) {
      unawaited(_loadLibraryContent(libraryGlobalKeyToLoad));
    }
  }

  @override
  void onTabChanged() {
    // What is on screen is the selector's business now, and it persists its own
    // choice — writing the tab name here would overwrite that with 'browse'.
    if (!suppressAutoFocus) _focusCurrentTab();
    super.onTabChanged();
  }

  /// Focus the first item in the currently active tab.
  /// Used for initial load and tab switching - focuses the grid content directly.
  void _focusCurrentTab() {
    // Don't focus during tab animations - wait for animation to complete
    // This prevents race conditions during focus restoration
    if (tabController.indexIsChanging) {
      return;
    }
    // On mobile (touch mode), skip auto-focus to prevent ensureVisible()
    // from interfering with TabBarView page animations
    if (!InputModeTracker.isKeyboardMode(context)) return;

    // Re-enable auto-focus since user is navigating into tab content
    // Only call setState if the value actually changes to avoid unnecessary rebuilds
    if (suppressAutoFocus) {
      setState(() {
        suppressAutoFocus = false;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final tabState = _getTabState(tabController.index);
      if (tabState != null) {
        (tabState as dynamic).focusContentOrChrome();
      } else {
        // State not available yet, retry after another frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _focusCurrentTabImmediate();
        });
      }
    });
  }

  /// Focus without additional frame delay (used for retry)
  void _focusCurrentTabImmediate() {
    final tabState = _getTabState(tabController.index);
    if (tabState != null) {
      (tabState as dynamic).focusContentOrChrome();
    }
  }

  /// Get the state for a tab by index
  State? _getTabState(int index) {
    if (index < 0 || index >= _visibleTabs.length) return null;
    return switch (_visibleTabs[index]) {
      LibraryTabType.browse => _browseTabKey.currentState,
      // Nothing outside asks the missing tab for its state.
      LibraryTabType.missing => null,
    };
  }

  void _showBrowseOptionsForCurrentTab() {
    if (_visibleTabs.isEmpty) return;
    final index = tabController.index.clamp(0, _visibleTabs.length - 1).toInt();
    if (_visibleTabs[index] != LibraryTabType.browse) return;
    final tabState = _browseTabKey.currentState;
    if (tabState == null) return;
    (tabState as dynamic).showBrowseOptionsSheet();
  }

  /// A view saved or deleted in the options sheet reaches the selector now,
  /// rather than when the library is next opened.
  void _handleViewsChanged(List<LibraryView> views) {
    if (!mounted) return;
    setState(() => _views = views);
  }

  /// Handle when the browse tab's active-filter state changes
  void _handleBrowseFiltersActiveChanged(bool active) {
    if (_browseFiltersActive == active) return;
    setState(() => _browseFiltersActive = active);
  }

  /// Handle when a tab's data has finished loading
  void _handleTabDataLoaded(int tabIndex) {
    // Track that this tab has loaded
    _loadedTabs.add(tabIndex);

    // Don't auto-focus if suppressed (e.g., when navigating via tab bar)
    if (suppressAutoFocus) return;

    // Only focus if this is the currently active tab
    if (tabController.index == tabIndex && mounted) {
      // Use post-frame callback to ensure the widget tree is fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && tabController.index == tabIndex && !suppressAutoFocus) {
          _focusCurrentTab();
        }
      });
    }
  }

  /// Called by parent when the Libraries screen becomes visible.
  /// If the active tab has already loaded data (often the case after preloading
  /// while on another main tab), re-request focus so the first item is focused
  /// once the screen is actually shown.
  @override
  void focusActiveTabIfReady() {
    if (_selectedLibraryGlobalKey == null) return;
    _focusCurrentTab();
  }

  @override
  void dispose() {
    _services?.removeListener(_recomputeMissingAvailability);
    _outerScrollController.dispose();
    for (final node in _tabFocusNodes) {
      node.dispose();
    }
    disposeTabNavigation();
    super.dispose();
  }

  void _updateState(VoidCallback fn) {
    if (!mounted) return;
    setState(fn);
  }

  /// Rebuild tab infrastructure when the visible tab set changes.

  Widget _buildSelectionContent(
    LibrarySelection selection, {
    required MediaLibrary library,
    required bool canGroupByFolders,
    required bool isActive,
    required int tabIndex,
  }) {
    if (selection.missing) return LibraryMissingTab(library: library);

    final view = selection.view;
    return switch (LibraryTabType.browse) {
      // Keyed by the view so each keeps its own scroll position, and only the
      // library's own contents report upward or take the shared key.
      LibraryTabType.browse => LibraryBrowseTab(
        key: view == null ? _browseTabKey : ValueKey('library_view_${view.name}'),
        library: library,
        view: view,
        canGroupByFolders: canGroupByFolders,
        isActive: isActive,
        suppressAutoFocus: suppressAutoFocus,
        onDataLoaded: () => _handleTabDataLoaded(tabIndex),
        onBack: focusTabBar,
        onResetScroll: view == null ? _resetOuterScroll : null,
        onFiltersActiveChanged: view == null ? _handleBrowseFiltersActiveChanged : null,
        onViewsChanged: view == null ? _handleViewsChanged : null,
      ),
      LibraryTabType.missing => const SizedBox.shrink(),
    };
  }

  /// Check if libraries come from multiple servers
  bool _hasMultipleServers(List<MediaLibrary> libraries) {
    final uniqueServerIds = libraries.where((lib) => lib.serverId != null).map((lib) => lib.serverId).toSet();
    return uniqueServerIds.length > 1;
  }

  /// Notify parent that library order changed
  void _notifyLibraryOrderChanged() {
    widget.onLibraryOrderChanged?.call();
  }

  /// Public method to load a library by key (called from MainScreen side nav)
  @override
  void loadLibraryByKey(String libraryGlobalKey) {
    _loadLibraryContent(libraryGlobalKey);
  }

  Future<void> _loadLibraryContent(String libraryGlobalKey) async {
    final librariesProvider = context.read<LibrariesProvider>();
    final allLibraries = librariesProvider.libraries;

    // Resolve from allLibraries — hidden libraries are still navigable from the
    // sidebar's "Hidden libraries" section.
    final selectedLibrary = allLibraries.where((lib) => lib.globalKey == libraryGlobalKey).firstOrNull;
    if (selectedLibrary == null) return;

    final isLibraryChange = _selectedLibraryGlobalKey != libraryGlobalKey;

    _librariesWithMissing = _librariesOfferingMissing(allLibraries, context.read<ManagedServicesProvider>());

    _updateState(() {
      _selectedLibraryGlobalKey = libraryGlobalKey;
      // A library change lands on its own contents; the saved selection is
      // restored below, once storage says what it was.
      if (isLibraryChange) _selection = LibrarySelection.library(libraryGlobalKey);
      _errorMessage = null;
      // Clear loaded tabs tracking for new library
      _loadedTabs.clear();
    });
    widget.onLibrarySelected?.call(libraryGlobalKey);

    // The new TabBarView mounts with fresh inner positions at offset 0;
    // bring the floating header back too. Also covers the case where the
    // newly-active tab is not browse (which would otherwise have no inner
    // jumpTo to catch via the browse-tab callback).
    if (isLibraryChange) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _resetOuterScroll();
      });
    }

    // Mark that initial load is complete
    if (_isInitialLoad) {
      _isInitialLoad = false;
    }

    // Save selected library key and restore saved tab (async — safe after state is consistent)
    final storage = await StorageService.getInstance();
    if (!mounted || _selectedLibraryGlobalKey != libraryGlobalKey) return;
    await storage.saveSelectedLibraryKey(libraryGlobalKey);
    if (!mounted || _selectedLibraryGlobalKey != libraryGlobalKey) return;

    // Views come from storage, so the selection they might name can only be
    // resolved here — a saved name that no longer exists falls back.
    final views = storage.getLibraryViews(libraryGlobalKey);
    final pending = _pendingSelection;
    _pendingSelection = null;
    final restored =
        pending ?? LibrarySelection.resolve(libraryGlobalKey, storage.getLibraryTab(libraryGlobalKey), views);
    if (!_sameViews(_views, views) || restored != _selection) {
      setState(() {
        _views = views;
        _selection = restored;
      });
    }

    // Focus is handled by onDataLoaded callbacks from each tab.
    // However, on first load the tab might finish loading before the tab index
    // is restored. Check if the current tab has already loaded and focus if so.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _selectedLibraryGlobalKey == libraryGlobalKey && _loadedTabs.contains(tabController.index)) {
        _focusCurrentTab();
      }
    });
  }

  @override
  void updateItemInLists(String sourceGlobalKey, MediaItem updatedItem) {
    // Delegate to the active tab — parent doesn't maintain its own item list
  }

  // Public method to refresh content (for normal navigation)
  @override
  void refresh() {
    _initializeWithLibraries();
  }

  // Refresh every loaded tab for the selected library.
  void _refreshSelectedLibraryTabs() {
    for (var i = 0; i < _visibleTabs.length; i++) {
      final Object? tabState = _getTabState(i);
      if (tabState is Refreshable) {
        tabState.refresh();
      }
    }
  }

  // Public method to fully reload all content (for profile switches)
  @override
  void fullRefresh() {
    appLogger.d('LibrariesScreen.fullRefresh() called - reloading all content');
    setState(() {
      _selectedLibraryGlobalKey = null;
      _errorMessage = null;
    });

    // Reinitialize with current libraries from provider
    _initializeWithLibraries();
  }

  Future<void> _toggleLibraryVisibility(MediaLibrary library) async {
    if (!mounted) return;
    final librariesProvider = context.read<LibrariesProvider>();
    final hiddenLibrariesProvider = Provider.of<HiddenLibrariesProvider>(context, listen: false);
    final isHidden = hiddenLibrariesProvider.hiddenLibraryKeys.contains(library.globalKey);

    if (isHidden) {
      await hiddenLibrariesProvider.unhideLibrary(library.globalKey);
    } else {
      final isCurrentlySelected = _selectedLibraryGlobalKey == library.globalKey;

      await hiddenLibrariesProvider.hideLibrary(library.globalKey);

      // If we just hid the selected library, select the first visible one
      if (isCurrentlySelected) {
        // Compute visible libraries after hiding
        final allLibraries = librariesProvider.libraries;
        final visibleLibraries = allLibraries
            .where((lib) => !hiddenLibrariesProvider.hiddenLibraryKeys.contains(lib.globalKey))
            .toList();

        if (visibleLibraries.isNotEmpty) {
          unawaited(_loadLibraryContent(visibleLibraries.first.globalKey));
        }
      }
    }
  }

  void _showLibraryManagementSheet() {
    showLibraryManagementSheet(
      context,
      onOrderChanged: _notifyLibraryOrderChanged,
      onToggleVisibility: _toggleLibraryVisibility,
    );
  }

  Widget _buildLibraryServerLabel(
    MediaLibrary library,
    TextStyle? style, {
    double badgeSize = 11,
    bool constrainText = false,
    String? fallbackServerName,
  }) {
    final serverName = library.serverName ?? fallbackServerName;
    if (serverName == null || serverName.isEmpty) return const SizedBox.shrink();

    final text = Text(serverName, style: style, overflow: .ellipsis);
    return Row(
      mainAxisSize: .min,
      children: [
        BackendBadge(backend: library.backend, size: badgeSize, color: style?.color),
        const SizedBox(width: 4),
        if (constrainText) Flexible(child: text) else text,
      ],
    );
  }

  /// Build the app bar title - either dropdown on mobile or simple title on desktop
  Widget _buildAppBarTitle(
    List<MediaLibrary> visibleLibraries,
    MediaLibrary? selectedLibrary, {
    required bool groupByServer,
  }) {
    // No selection at all, or visible list is empty AND we're not browsing a hidden library
    if (_selectedLibraryGlobalKey == null || (visibleLibraries.isEmpty && selectedLibrary == null)) {
      return Text(t.libraries.title);
    }

    // On desktop/TV with side nav, show tabs in app bar (library name is in side nav)
    return _buildLibraryDropdownTitle(visibleLibraries, groupByServer: groupByServer);
  }

  Widget _buildLibraryDropdownTitle(List<MediaLibrary> visibleLibraries, {required bool groupByServer}) {
    final selectedLibrary =
        visibleLibraries.where((lib) => lib.globalKey == _selectedLibraryGlobalKey).firstOrNull ??
        visibleLibraries.firstOrNull;
    if (selectedLibrary == null) return Text(t.libraries.title);

    return Semantics(
      button: true,
      label: t.libraries.selectLibrary,
      child: InkWell(
        onTap: () => _showLibraryPicker(visibleLibraries, groupByServer: groupByServer),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisSize: .min,
            children: [
              AppIcon(ContentTypeHelper.getLibraryIcon(selectedLibrary.kind.id), size: 20),
              const SizedBox(width: 8),
              if (_hasMultipleServers(visibleLibraries) && selectedLibrary.serverName != null)
                Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    Text(selectedLibrary.title, style: Theme.of(context).textTheme.titleMedium),
                    _buildLibraryServerLabel(
                      selectedLibrary,
                      Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                      ),
                      badgeSize: 10,
                    ),
                  ],
                )
              else
                Text(selectedLibrary.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 19)),
              const SizedBox(width: 4),
              const AppIcon(PhosphorIcons.caretDown, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showLibraryPicker(List<MediaLibrary> visibleLibraries, {required bool groupByServer}) {
    final controller = OverlaySheetController.of(context);
    unawaited(
      controller
          .show<LibrarySelection>(
            constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.62),
            builder: (_) => LibraryQuickPickerSheet(
              libraries: visibleLibraries,
              selectedLibraryKey: _selectedLibraryGlobalKey,
              selection: _selection,
              viewsByLibrary: {?_selectedLibraryGlobalKey: _views},
              librariesWithMissing: _librariesWithMissing,
              isLoading: false,
              groupByServer: groupByServer,
              emptyMessage: t.libraries.noLibrariesFound,
              onSelected: controller.close,
            ),
          )
          .then(_handleSelection),
    );
  }

  /// A different library reloads; a different way of looking at the same one
  /// only swaps the body, which is why the two are not one path.
  void _handleSelection(LibrarySelection? selection) {
    if (selection == null || !mounted) return;
    if (selection.libraryGlobalKey != _selectedLibraryGlobalKey) {
      _pendingSelection = selection;
      _loadLibraryContent(selection.libraryGlobalKey);
      return;
    }
    if (selection == _selection) return;
    setState(() => _selection = selection);
    unawaited(_persistSelection(selection));
  }

  /// Carried across a library change, since the content load resets the
  /// selection to that library's own contents before this can apply.
  LibrarySelection? _pendingSelection;

  Future<void> _persistSelection(LibrarySelection selection) async {
    final storage = await StorageService.getInstance();
    await storage.saveLibraryTab(selection.libraryGlobalKey, selection.storageName);
  }

  @override
  Widget build(BuildContext context) {
    return SettingValueBuilder<bool>(
      pref: SettingsService.groupLibrariesByServer,
      builder: (context, groupByServerSetting, _) => _buildContent(context, groupByServerSetting),
    );
  }

  Widget _buildContent(BuildContext context, bool groupByServerSetting) {
    final librariesProvider = context.watch<LibrariesProvider>();
    final allLibraries = librariesProvider.libraries;
    final isLoadingLibraries = librariesProvider.isLoading;

    // Watch for hidden libraries changes to trigger rebuild
    final hiddenLibrariesProvider = context.watch<HiddenLibrariesProvider>();
    final hiddenKeys = hiddenLibrariesProvider.hiddenLibraryKeys;

    final visibleLibraries = allLibraries.where((lib) => !hiddenKeys.contains(lib.globalKey)).toList();

    // Resolve selected library defensively — may be null if server temporarily dropped during refresh
    final selectedLibrary = _selectedLibraryGlobalKey != null
        ? allLibraries.where((lib) => lib.globalKey == _selectedLibraryGlobalKey).firstOrNull
        : null;

    final currentTabIndex = _visibleTabs.isEmpty ? 0 : tabController.index.clamp(0, _visibleTabs.length - 1).toInt();
    final currentTabType = _visibleTabs.isEmpty ? null : _visibleTabs[currentTabIndex];
    final showBrowseOptionsAction =
        selectedLibrary != null && PlatformDetector.isMobile(context) && currentTabType == LibraryTabType.browse;
    List<FocusableAction> appBarActions() => [
      if (allLibraries.isNotEmpty)
        FocusableAction(
          icon: PhosphorIcons.pencilSimple,
          tooltip: t.libraries.manageLibraries,
          onPressed: _showLibraryManagementSheet,
        ),
      if (showBrowseOptionsAction)
        FocusableAction(
          icon: PhosphorIcons.sliders,
          tooltip: t.libraries.libraryOptions,
          onPressed: _showBrowseOptionsForCurrentTab,
          // Badge the icon with a dot while the browse tab has active filters
          // (issue #1470). A null child keeps the default rendering.
          child: _browseFiltersActive
              ? IconButton(
                  tooltip: t.libraries.libraryOptions,
                  onPressed: _showBrowseOptionsForCurrentTab,
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const AppIcon(PhosphorIcons.sliders),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      // Each tab wraps its content in a RefreshIndicator calling the same
      // loadItems, so handheld reaches this by pulling. The button stays on
      // TV/desktop, where it also refreshes every visible tab at once.
      if (!PlatformDetector.isHandheld(context))
        FocusableAction(
          icon: PhosphorIcons.arrowsClockwise,
          tooltip: t.common.refresh,
          onPressed: _refreshSelectedLibraryTabs,
        ),
    ];

    Widget appBar({required bool floating}) => DesktopSliverAppBar(
      title: _buildAppBarTitle(visibleLibraries, selectedLibrary, groupByServer: groupByServerSetting),
      // When showing the tab content, let the app bar float away with the
      // content. Otherwise (loading / empty / error states) keep it pinned so
      // it stays visible over the centered state widget.
      pinned: !floating,
      floating: floating,
      snap: floating,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      actions: [
        FocusableActionBar(
          key: _actionBarKey,
          onNavigateLeft: () => getTabChipFocusNode(_visibleTabs.length - 1).requestFocus(),
          onNavigateDown: _focusCurrentTab,
          actions: appBarActions(),
        ),
      ],
    );

    Widget buildSimpleScroll({required Widget body}) {
      return CustomScrollView(
        controller: _outerScrollController,
        slivers: [
          appBar(floating: false),
          SliverFillRemaining(child: body),
        ],
      );
    }

    Widget body;
    if (isLoadingLibraries) {
      body = buildSimpleScroll(body: const Center(child: CircularProgressIndicator()));
    } else if (_errorMessage != null && visibleLibraries.isEmpty && selectedLibrary == null) {
      body = buildSimpleScroll(
        body: ErrorStateWidget(
          message: _errorMessage!,
          icon: PhosphorIcons.warningCircle,
          onRetry: () {
            final librariesProvider = context.read<LibrariesProvider>();
            librariesProvider.refresh();
          },
        ),
      );
    } else if (visibleLibraries.isEmpty && selectedLibrary == null) {
      body = buildSimpleScroll(
        body: allLibraries.isEmpty
            ? EmptyStateWidget(message: t.libraries.noLibrariesFound, icon: PhosphorIcons.filmSlate)
            : EmptyStateWidget(
                message: t.libraries.allLibrariesHidden,
                icon: PhosphorIcons.eyeSlash,
                onAction: _showLibraryManagementSheet,
                actionLabel: t.libraries.manageLibraries,
                actionIcon: PhosphorIcons.pencilSimple,
              ),
      );
    } else if (selectedLibrary != null) {
      final selection = _selection ?? LibrarySelection.library(selectedLibrary.globalKey);

      // One body, keyed by what it shows, so switching selection mounts fresh
      // state rather than reusing the previous one's scroll and paging.
      Widget buildTabs() => ClipRect(
        key: ValueKey('${selectedLibrary.globalKey}/${selection.storageName}'),
        // Overflow from a hub row (Clip.none) must not bleed past the body.
        child: _buildSelectionContent(
          selection,
          library: selectedLibrary,
          canGroupByFolders: true,
          isActive: true,
          tabIndex: 0,
        ),
      );

      body = NestedScrollView(
        controller: _outerScrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: appBar(floating: true),
          ),
        ],
        body: buildTabs(),
      );
    } else {
      body = buildSimpleScroll(body: const SizedBox.shrink());
    }

    final scrollBody = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: body,
    );

    return Scaffold(body: scrollBody);
  }
}
