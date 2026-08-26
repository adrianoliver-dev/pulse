import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ai/gemini_key.dart';
import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/models/appearance.dart';
import '../../core/models/phase.dart';
import '../../l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final palette = context.pulse;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: PulsePage(
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _SectionLabel(l10n.appearance, palette),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(l10n.themeLabel, style: TextStyle(color: palette.textMuted)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppThemeId.values.map((id) {
                final swatch = PulsePalette.ofId(id);
                final selected = settings.themeId == id;
                final label = switch (id) {
                  AppThemeId.clock => l10n.themeClock,
                  AppThemeId.atelier => l10n.themeAtelier,
                  AppThemeId.lab => l10n.themeLab,
                  AppThemeId.tierra => l10n.themeTierra,
                };
                return GestureDetector(
                  onTap: () => ref.read(settingsProvider.notifier).setThemeId(id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 92,
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                    decoration: BoxDecoration(
                      color: swatch.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected ? swatch.accent : swatch.hairline,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: swatch.accent,
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          label,
                          style: TextStyle(
                            color: swatch.text,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(l10n.timerLayout, style: TextStyle(color: palette.textMuted)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final layout in TimerLayout.values)
                  ChoiceChip(
                    label: Text(
                      switch (layout) {
                        TimerLayout.giant => l10n.layoutGiant,
                        TimerLayout.ring => l10n.layoutRing,
                        TimerLayout.both => l10n.layoutBoth,
                      },
                      style: TextStyle(
                        color: settings.timerLayout == layout
                            ? palette.background
                            : palette.text,
                      ),
                    ),
                    selected: settings.timerLayout == layout,
                    selectedColor: palette.accent,
                    backgroundColor: palette.surfaceHigh,
                    onSelected: (_) =>
                        ref.read(settingsProvider.notifier).setTimerLayout(layout),
                  ),
              ],
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: Text(l10n.haptics),
            value: settings.haptics,
            activeThumbColor: palette.accent,
            onChanged: (v) => ref.read(settingsProvider.notifier).setHaptics(v),
          ),
          SwitchListTile(
            title: Text(l10n.countdownBeeps),
            value: settings.countdownBeeps,
            activeThumbColor: palette.accent,
            onChanged: (v) =>
                ref.read(settingsProvider.notifier).setCountdownBeeps(v),
          ),
          const Divider(),
          _SectionLabel(l10n.musicDuringRest, palette),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              l10n.musicPolicyHint,
              style: TextStyle(color: palette.textMuted, height: 1.4),
            ),
          ),
          RadioGroup<MusicBehavior>(
            groupValue: settings.musicBehavior,
            onChanged: (v) {
              if (v != null) {
                ref.read(settingsProvider.notifier).setMusicBehavior(v);
              }
            },
            child: Column(
              children: [
                MusicBehavior.alwaysOn,
                MusicBehavior.duckOnRest,
                MusicBehavior.pauseOnRest,
                MusicBehavior.off,
              ].map((b) {
                final label = switch (b) {
                  MusicBehavior.pauseOnRest => l10n.musicPause,
                  MusicBehavior.duckOnRest => l10n.musicDuck,
                  MusicBehavior.alwaysOn => l10n.musicKeep,
                  MusicBehavior.off => l10n.musicOff,
                };
                return RadioListTile<MusicBehavior>(
                  title: Text(label),
                  value: b,
                );
              }).toList(),
            ),
          ),
          const Divider(),
          _SectionLabel(l10n.language, palette),
          RadioGroup<String?>(
            groupValue: settings.localeCode,
            onChanged: (v) => ref.read(settingsProvider.notifier).setLocaleCode(v),
            child: Column(
              children: [
                RadioListTile<String?>(
                  title: Text(l10n.languageSystem),
                  value: null,
                ),
                RadioListTile<String?>(
                  title: Text(l10n.languageEs),
                  value: 'es',
                ),
                RadioListTile<String?>(
                  title: Text(l10n.languageEn),
                  value: 'en',
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(l10n.replayOnboarding),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                ref.read(settingsProvider.notifier).setOnboardingDone(false),
          ),
          const Divider(),
          _SectionLabel(l10n.coachTitle, palette),
          if (geminiApiKey.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                l10n.coachReady,
                style: TextStyle(color: palette.textMuted),
              ),
            ),
          ListTile(
            title: Text(l10n.geminiKeyLabel),
            subtitle: Text(l10n.geminiKeyHint),
            onTap: () => _editGeminiKey(context, ref, settings.geminiUserKey),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(l10n.privacy, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.privacyBody,
              style: TextStyle(color: palette.textMuted, height: 1.4),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.aboutPulse,
              style: TextStyle(color: palette.textMuted, height: 1.4),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.versionLabel('1.1.0'),
              style: TextStyle(color: palette.textMuted),
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, this.palette);
  final String label;
  final PulsePalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(label, style: TextStyle(color: palette.textMuted)),
    );
  }
}

Future<void> _editGeminiKey(
  BuildContext context,
  WidgetRef ref,
  String? current,
) async {
  final l10n = AppLocalizations.of(context);
  final controller = TextEditingController(text: current ?? '');
  final value = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.geminiKeyLabel),
      content: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(hintText: l10n.geminiKeyHint),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
        TextButton(
          onPressed: () => Navigator.pop(ctx, controller.text.trim()),
          child: Text(l10n.save),
        ),
      ],
    ),
  );
  if (value == null) return;
  await ref.read(settingsProvider.notifier).setGeminiUserKey(value);
}
