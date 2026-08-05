import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every overlay drawer builds its rows from the app menu's row, so none of them
/// can drift back to ListTile's 16sp title beside the menu's 14sp.
///
/// Dialogs, settings screens and screen bodies keep ListTile: they are not
/// drawers, and a settings screen is scanned rather than picked from.
void main() {
  test('a shelf heading is never hand-rolled', () {
    // Every shelf reads at one heading scale. A file that writes its own
    // fontSize beside a section title is how the requested-titles row ended up
    // 15sp against every other shelf's 18sp.
    const shelves = [
      'lib/widgets/requested_titles_row.dart',
      'lib/widgets/hub_section.dart',
      'lib/screens/media_detail/detail_design.dart',
      'lib/screens/catalog_item_detail_screen.dart',
    ];

    for (final path in shelves) {
      final source = File(path).readAsStringSync();
      expect(
        source.contains('HubLayoutConstants.sectionHeading'),
        isTrue,
        reason: '$path should take its section heading from the shared style',
      );
    }
  });

  test('no sheet builds its rows from a ListTile variant', () {
    const drawers = [
      'lib/screens/libraries/filters_bottom_sheet.dart',
      'lib/screens/libraries/library_quick_picker_sheet.dart',
      'lib/screens/libraries/sort_bottom_sheet.dart',
      'lib/screens/libraries/tabs/library_browse_tab.dart',
      'lib/screens/media_detail/season_picker.dart',
      'lib/widgets/arr_search_sheet.dart',
      'lib/widgets/episode_detail_sheet.dart',
      'lib/widgets/file_info_bottom_sheet.dart',
      'lib/widgets/library_management_sheet.dart',
      'lib/widgets/media_context_menu.dart',
      'lib/widgets/rating_bottom_sheet.dart',
      'lib/widgets/seerr_request_sheet.dart',
      'lib/widgets/video_controls/helpers/track_selection_helper.dart',
      'lib/widgets/video_controls/sheets/chapter_sheet.dart',
      'lib/widgets/video_controls/sheets/queue_sheet.dart',
      'lib/widgets/video_controls/sheets/track_sheet.dart',
      'lib/widgets/video_controls/sheets/version_quality_sheet.dart',
      'lib/widgets/video_controls/sheets/video_settings_sheet.dart',
      'lib/widgets/video_controls/widgets/sleep_timer_content.dart',
    ];

    final offenders = <String>[];
    for (final path in drawers) {
      final file = File(path);
      expect(file.existsSync(), isTrue, reason: '$path moved; update this list');
      final source = file.readAsStringSync();
      for (final row in ['FocusableListTile(', 'FocusableSwitchListTile(', 'CheckboxListTile(', 'SwitchListTile(']) {
        if (source.contains(row)) offenders.add('$path uses $row');
      }
    }

    expect(offenders, isEmpty);
  });
}
