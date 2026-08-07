import 'package:flutter/material.dart';
import 'package:harbor/widgets/app_icon.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import '../../focus/focusable_button.dart';
import '../../focus/input_mode_tracker.dart';
import '../../media/media_filter.dart';
import 'state_messages.dart';
import '../../utils/app_logger.dart';
import '../../utils/scroll_utils.dart';
import '../../widgets/bottom_sheet_page_scaffold.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/overlay_sheet.dart';
import '../../i18n/strings.g.dart';
import '../../media/library_view.dart';

typedef FilterValuesLoader = Future<List<MediaFilterValue>> Function(MediaFilter filter);

class FiltersBottomSheet extends StatefulWidget {
  final List<MediaFilter> filters;
  final Map<String, String> selectedFilters;
  final Function(Map<String, String>) onFiltersChanged;
  final String serverId;
  final String libraryKey;
  final FilterValuesLoader loadFilterValues;
  final VoidCallback? onBack;

  /// Build or edit a saved view instead of filtering the library directly.
  ///
  /// The quick path applies and closes on every value tap, which is right when
  /// one filter is the whole intent. A view is a set, so this mode accumulates
  /// and waits for Done, and carries the name the chip will show.
  final bool asView;

  /// The view being edited, or null when building a new one. Only an existing
  /// view can be deleted.
  final LibraryView? editingView;
  final ValueChanged<LibraryView>? onSaveView;
  final ValueChanged<LibraryView>? onDeleteView;

  /// Optional pre-fetched values per filter name. When non-null the sheet
  /// reads from this instead of calling `client.getFilterValues` — used
  /// for Jellyfin libraries where values come back in the same call that
  /// lists the categories.
  final Map<String, List<MediaFilterValue>>? cachedValues;

  const FiltersBottomSheet({
    super.key,
    required this.filters,
    required this.selectedFilters,
    required this.onFiltersChanged,
    required this.serverId,
    required this.libraryKey,
    required this.loadFilterValues,
    this.onBack,
    this.cachedValues,
    this.asView = false,
    this.editingView,
    this.onSaveView,
    this.onDeleteView,
  });

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  MediaFilter? _currentFilter;
  List<MediaFilterValue> _filterValues = [];
  bool _isLoadingValues = false;
  String? _filterValuesError;
  int _filterValuesLoadGeneration = 0;
  final Map<String, String> _tempSelectedFilters = {};
  static final Map<String, String> _filterDisplayNames = {}; // Cache for display names
  static const int _maxCachedDisplayNames = 1000;
  late List<MediaFilter> _sortedFilters;
  late final FocusNode _initialFocusNode;
  late final TextEditingController _nameController;
  final _valuesFirstItemKey = GlobalKey();
  final _valuesScrollController = ScrollController();

  String _cacheKey(String filter, String value) => '${widget.serverId}:${widget.libraryKey}:$filter:$value';

  @override
  void initState() {
    super.initState();
    _tempSelectedFilters.addAll(widget.selectedFilters);
    _sortFilters();
    _initialFocusNode = FocusNode(debugLabel: 'FiltersBottomSheetInitialFocus');
    _nameController = TextEditingController(text: widget.editingView?.name ?? '');
  }

  @override
  void didUpdateWidget(covariant FiltersBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    final ownerChanged = oldWidget.serverId != widget.serverId || oldWidget.libraryKey != widget.libraryKey;
    if (ownerChanged) {
      _filterValuesLoadGeneration++;
      _currentFilter = null;
      _filterValues = [];
      _isLoadingValues = false;
      _filterValuesError = null;
      _tempSelectedFilters
        ..clear()
        ..addAll(widget.selectedFilters);
    }
    if (ownerChanged || !identical(oldWidget.filters, widget.filters)) {
      _sortFilters();
    }
  }

  @override
  void dispose() {
    _filterValuesLoadGeneration++;
    _valuesScrollController.dispose();
    _initialFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _sortFilters() {
    // Separate boolean filters (toggles) from regular filters
    final booleanFilters = widget.filters.where((f) => f.filterType == 'boolean').toList();
    final regularFilters = widget.filters.where((f) => f.filterType != 'boolean').toList();

    // Combine with boolean filters first
    _sortedFilters = [...booleanFilters, ...regularFilters];
  }

  bool _isBooleanFilter(MediaFilter filter) {
    return filter.filterType == 'boolean';
  }

  Future<void> _loadFilterValues(MediaFilter filter) async {
    final generation = ++_filterValuesLoadGeneration;
    final filterKey = filter.filter;
    final serverId = widget.serverId;
    final libraryKey = widget.libraryKey;
    final cachedValues = widget.cachedValues;
    final loader = widget.loadFilterValues;
    setState(() {
      _currentFilter = filter;
      _filterValues = [];
      _isLoadingValues = true;
      _filterValuesError = null;
    });

    try {
      // Cached path (Jellyfin) - `/Items/Filters` returned values inline.
      final cached = cachedValues?[filterKey];
      final values = cached ?? await loader(filter);
      if (!_isCurrentFilterValuesLoad(generation, serverId, libraryKey, filterKey)) return;

      final selectedValue = _tempSelectedFilters[filterKey];
      final selectedIndex = selectedValue == null
          ? -1
          : values.indexWhere((value) => _extractFilterValue(value.key, filterKey) == selectedValue);
      setState(() {
        _filterValues = values;
        _isLoadingValues = false;
      });
      _requestInitialFocus(generation, serverId, libraryKey, filterKey);
      if (selectedIndex >= 0) {
        // +1 because index 0 is the "All" row.
        scrollToCurrentItem(
          _valuesScrollController,
          _valuesFirstItemKey,
          selectedIndex + 1,
          isCurrent: () => _isCurrentFilterValuesLoad(generation, serverId, libraryKey, filterKey),
        );
      }
    } catch (e, stackTrace) {
      if (!_isCurrentFilterValuesLoad(generation, serverId, libraryKey, filterKey)) return;
      appLogger.w('Failed to load values for filter $filterKey', error: e, stackTrace: stackTrace);
      setState(() {
        _filterValues = [];
        _isLoadingValues = false;
        _filterValuesError = t.errors.unableToLoad(context: filter.title);
      });
      _requestInitialFocus(generation, serverId, libraryKey, filterKey);
    }
  }

  bool _isCurrentFilterValuesLoad(int generation, String serverId, String libraryKey, String? filterKey) {
    return mounted &&
        generation == _filterValuesLoadGeneration &&
        widget.serverId == serverId &&
        widget.libraryKey == libraryKey &&
        _currentFilter?.filter == filterKey;
  }

  void _goBack() {
    final generation = ++_filterValuesLoadGeneration;
    final serverId = widget.serverId;
    final libraryKey = widget.libraryKey;
    setState(() {
      _currentFilter = null;
      _filterValues = [];
      _isLoadingValues = false;
      _filterValuesError = null;
    });
    _requestInitialFocus(generation, serverId, libraryKey, null);
  }

  void _requestInitialFocus(int generation, String serverId, String libraryKey, String? filterKey) {
    if (!InputModeTracker.isKeyboardMode(context)) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isCurrentFilterValuesLoad(generation, serverId, libraryKey, filterKey)) return;
      if (_initialFocusNode.context != null) {
        _initialFocusNode.requestFocus();
      } else {
        OverlaySheetController.maybeOf(context)?.refocus();
      }
    });
  }

  void _clearFilters() {
    _filterValuesLoadGeneration++;
    setState(() {
      _tempSelectedFilters.clear();
    });
    _applyFilters();
  }

  /// A tap commits immediately when filtering, and only accumulates when
  /// building a view.
  void _applyFilters() {
    if (widget.asView) return;
    _filterValuesLoadGeneration++;
    widget.onFiltersChanged(Map<String, String>.of(_tempSelectedFilters));
    OverlaySheetController.of(context).close();
  }

  void _saveView() {
    final name = _nameController.text.trim();
    _filterValuesLoadGeneration++;
    widget.onSaveView?.call(
      LibraryView(
        name: name.isEmpty ? t.libraries.views.unnamed : name,
        filters: Map<String, String>.of(_tempSelectedFilters),
      ),
    );
    OverlaySheetController.of(context).close();
  }

  void _deleteView() {
    final editing = widget.editingView;
    if (editing == null) return;
    _filterValuesLoadGeneration++;
    widget.onDeleteView?.call(editing);
    OverlaySheetController.of(context).close();
  }

  String _extractFilterValue(String key, String filterName) {
    if (key.contains('?')) {
      final queryStart = key.indexOf('?');
      final queryString = key.substring(queryStart + 1);
      final params = Uri.splitQueryString(queryString);
      return params[filterName] ?? key;
    } else if (key.startsWith('/')) {
      return key.split('/').last;
    }
    return key;
  }

  @override
  Widget build(BuildContext context) {
    final currentFilter = _currentFilter;
    return BottomSheetPageScaffold(
      title: currentFilter?.title ?? t.libraries.filters,
      icon: PhosphorIcons.funnel,
      onBack: currentFilter != null ? _goBack : widget.onBack,
      action: _headerAction(currentFilter),
      child: currentFilter != null ? _buildFilterValuesView(currentFilter) : _buildFiltersView(),
    );
  }

  Widget? _headerAction(MediaFilter? currentFilter) {
    if (currentFilter != null) return null;
    if (widget.asView) {
      return FocusableButton(
        onPressed: _saveView,
        child: TextButton(onPressed: _saveView, child: Text(t.libraries.views.done)),
      );
    }
    if (_tempSelectedFilters.isEmpty) return null;
    return FocusableButton(
      onPressed: _clearFilters,
      child: TextButton.icon(
        onPressed: _clearFilters,
        icon: const AppIcon(PhosphorIcons.eraser),
        label: Text(t.libraries.clearAll),
      ),
    );
  }

  Widget _buildFilterValuesView(MediaFilter filter) {
    final error = _filterValuesError;
    if (error != null) {
      return ErrorStateWidget(
        message: error,
        onRetry: () => _loadFilterValues(filter),
        actionFocusNode: _initialFocusNode,
        onActionBack: _goBack,
        actionAutofocus: InputModeTracker.isKeyboardMode(context),
        actionUseBackgroundFocus: true,
      );
    }
    if (_isLoadingValues) {
      return Focus(
        autofocus: InputModeTracker.isKeyboardMode(context),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final autofocusFirst = InputModeTracker.isKeyboardMode(context);
    return ListView.builder(
      controller: _valuesScrollController,
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filterValues.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          final isSelected = !_tempSelectedFilters.containsKey(filter.filter);
          return AppMenuItemTile<String>(
            key: _valuesFirstItemKey,
            focusNode: _initialFocusNode,
            autofocus: autofocusFirst,
            item: AppMenuItem<String>(value: '', label: t.libraries.all, selected: isSelected),
            onPressed: () {
              setState(() {
                _tempSelectedFilters.remove(filter.filter);
              });
              _applyFilters();
            },
          );
        }

        final value = _filterValues[index - 1];
        final filterValue = _extractFilterValue(value.key, filter.filter);
        final isSelected = _tempSelectedFilters[filter.filter] == filterValue;

        return AppMenuItemTile<String>(
          item: AppMenuItem<String>(value: filterValue, label: value.title, selected: isSelected),
          onPressed: () {
            setState(() {
              _tempSelectedFilters[filter.filter] = filterValue;
              // Cache the display name for this filter value.
              if (_filterDisplayNames.length > _maxCachedDisplayNames) {
                _filterDisplayNames.clear();
              }
              _filterDisplayNames[_cacheKey(filter.filter, filterValue)] = value.title;
            });
            _applyFilters();
          },
        );
      },
    );
  }

  Widget _buildFiltersView() {
    final autofocusFirst = InputModeTracker.isKeyboardMode(context);
    // Named inline rather than by a dialog after Done: the chip needs a short
    // label, and the filters alone make one too long to read.
    final leading = widget.asView ? 1 : 0;
    final trailing = widget.asView && widget.editingView != null ? 1 : 0;
    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _sortedFilters.length + leading + trailing,
      itemBuilder: (context, rawIndex) {
        if (leading == 1 && rawIndex == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _saveView(),
              decoration: InputDecoration(labelText: t.libraries.views.nameLabel),
            ),
          );
        }
        final index = rawIndex - leading;
        if (index >= _sortedFilters.length) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextButton.icon(
              onPressed: _deleteView,
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              icon: const AppIcon(PhosphorIcons.trash),
              label: Text(t.libraries.views.deleteView),
            ),
          );
        }
        final filter = _sortedFilters[index];

        // Handle boolean filters as switches (unwatched, inProgress, unmatched, hdr, etc.)
        if (_isBooleanFilter(filter)) {
          final isActive =
              _tempSelectedFilters.containsKey(filter.filter) && _tempSelectedFilters[filter.filter] == '1';
          void toggle({required bool on}) {
            setState(() {
              if (on) {
                _tempSelectedFilters[filter.filter] = '1';
              } else {
                _tempSelectedFilters.remove(filter.filter);
              }
            });
            _applyFilters();
          }

          return AppMenuItemTile<String>(
            focusNode: index == 0 ? _initialFocusNode : null,
            autofocus: index == 0 && autofocusFirst,
            item: AppMenuItem<String>(value: filter.filter, label: filter.title, selected: isActive),
            onPressed: () => toggle(on: !isActive),
          );
        }

        // Regular navigable filters - show selected value instead of checkmark
        final selectedValue = _tempSelectedFilters[filter.filter];
        String? displayValue;
        if (selectedValue != null) {
          // Try to get the cached display name, fall back to the value itself
          displayValue = _filterDisplayNames[_cacheKey(filter.filter, selectedValue)] ?? selectedValue;
        }

        return AppMenuItemTile<String>(
          focusNode: index == 0 ? _initialFocusNode : null,
          autofocus: index == 0 && autofocusFirst,
          item: AppMenuItem<String>(
            value: filter.filter,
            label: filter.title,
            trailing: Row(
              mainAxisSize: .min,
              children: [
                if (displayValue != null)
                  Flexible(
                    child: Text(
                      displayValue,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: .w500),
                      overflow: .ellipsis,
                    ),
                  ),
                if (displayValue != null) const SizedBox(width: 8),
                const AppIcon(PhosphorIcons.caretRight),
              ],
            ),
          ),
          onPressed: () => _loadFilterValues(filter),
        );
      },
    );
  }
}
