import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../i18n/strings.g.dart';
import '../../services/settings_service.dart';
import '../../widgets/setting_tile.dart';
import '../../widgets/settings_page.dart';
import '../../widgets/settings_section.dart';
import 'settings_utils.dart';

class SubtitleStylingScreen extends StatelessWidget {
  const SubtitleStylingScreen({super.key});

  String _assOverrideLabel(SubAssOverride value) {
    return switch (value) {
      SubAssOverride.no => t.common.no,
      SubAssOverride.yes => t.common.yes,
      SubAssOverride.scale => t.subtitlingStyling.overrideScale,
      SubAssOverride.force => t.subtitlingStyling.overrideForce,
      SubAssOverride.strip => t.subtitlingStyling.overrideStrip,
    };
  }

  String _formatPosition(int value) {
    if (value == 0) return t.subtitlingStyling.positionTop;
    if (value == 100) return t.subtitlingStyling.positionBottom;
    return '$value%';
  }

  String _renderResolutionLabel(SubtitleRenderResolution value) {
    return switch (value) {
      SubtitleRenderResolution.screen => t.subtitlingStyling.renderResolutionScreen,
      SubtitleRenderResolution.video => t.subtitlingStyling.renderResolutionVideo,
      SubtitleRenderResolution.threeQuarter => '¾',
      SubtitleRenderResolution.half => '½',
      SubtitleRenderResolution.third => '⅓',
      SubtitleRenderResolution.quarter => '¼',
    };
  }

  @override
  Widget build(BuildContext context) {
    return SettingsPage(
      title: Text(t.screens.subtitleStyling),
      children: [
        SettingsGroup(
          title: t.subtitlingStyling.text,
          children: [
            SettingSelectionTile<SubAssOverride>(
              pref: SettingsService.subAssOverride,
              icon: TablerIcons.badgeCc,
              title: t.subtitlingStyling.assOverride,
              subtitleBuilder: _assOverrideLabel,
              options: SubAssOverride.values.map((v) => DialogOption(value: v, title: _assOverrideLabel(v))).toList(),
            ),
            // iOS/tvOS avfoundation VO: screen vs video-resolution basis.
            if (Platform.isIOS)
              SettingSelectionTile<SubtitleRenderResolution>(
                pref: SettingsService.subtitleRenderResolution,
                icon: TablerIcons.aspectRatio,
                title: t.subtitlingStyling.renderResolution,
                subtitleBuilder: _renderResolutionLabel,
                options: const [
                  SubtitleRenderResolution.screen,
                  SubtitleRenderResolution.video,
                ].map((v) => DialogOption(value: v, title: _renderResolutionLabel(v))).toList(),
              ),
            // Android libass overlay: full or a fractional render scale (perf knob for
            // render-bound low-end TVs; heavy/animated signs raster faster at < 1).
            if (Platform.isAndroid)
              SettingSelectionTile<SubtitleRenderResolution>(
                pref: SettingsService.subtitleRenderResolution,
                icon: TablerIcons.aspectRatio,
                title: t.subtitlingStyling.renderResolution,
                subtitleBuilder: _renderResolutionLabel,
                options: const [
                  SubtitleRenderResolution.screen,
                  SubtitleRenderResolution.threeQuarter,
                  SubtitleRenderResolution.half,
                  SubtitleRenderResolution.third,
                  SubtitleRenderResolution.quarter,
                ].map((v) => DialogOption(value: v, title: _renderResolutionLabel(v))).toList(),
              ),
            SettingNumberTile(
              pref: SettingsService.subtitleFontSize,
              icon: TablerIcons.textSize,
              title: t.subtitlingStyling.fontSize,
              subtitleBuilder: (v) => '$v',
              labelText: t.subtitlingStyling.fontSize,
              suffixText: '',
              min: 10,
              max: 80,
            ),
            SettingColorTile(
              pref: SettingsService.subtitleTextColor,
              icon: TablerIcons.textSize,
              title: t.subtitlingStyling.textColor,
            ),
            SettingNumberTile(
              pref: SettingsService.subtitlePosition,
              icon: TablerIcons.arrowBarToDown,
              title: t.subtitlingStyling.position,
              subtitleBuilder: _formatPosition,
              labelText: t.subtitlingStyling.position,
              suffixText: '%',
              min: 0,
              max: 100,
            ),
            SettingSwitchTile(
              pref: SettingsService.subtitleBold,
              icon: TablerIcons.bold,
              title: t.subtitlingStyling.bold,
            ),
            SettingSwitchTile(
              pref: SettingsService.subtitleItalic,
              icon: TablerIcons.italic,
              title: t.subtitlingStyling.italic,
            ),
          ],
        ),

        SettingsGroup(
          title: t.subtitlingStyling.border,
          children: [
            SettingNumberTile(
              pref: SettingsService.subtitleBorderSize,
              icon: TablerIcons.squareHalf,
              title: t.subtitlingStyling.borderSize,
              subtitleBuilder: (v) => '$v',
              labelText: t.subtitlingStyling.borderSize,
              suffixText: '',
              min: 0,
              max: 5,
            ),
            SettingColorTile(
              pref: SettingsService.subtitleBorderColor,
              icon: TablerIcons.brush,
              title: t.subtitlingStyling.borderColor,
            ),
          ],
        ),

        SettingsGroup(
          title: t.subtitlingStyling.background,
          children: [
            SettingNumberTile(
              pref: SettingsService.subtitleBackgroundOpacity,
              icon: TablerIcons.droplet,
              title: t.subtitlingStyling.backgroundOpacity,
              subtitleBuilder: (v) => '$v%',
              labelText: t.subtitlingStyling.backgroundOpacity,
              suffixText: '%',
              min: 0,
              max: 100,
            ),
            SettingColorTile(
              pref: SettingsService.subtitleBackgroundColor,
              icon: TablerIcons.bucket,
              title: t.subtitlingStyling.backgroundColor,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
