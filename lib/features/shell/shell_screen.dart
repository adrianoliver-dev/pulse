import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../music/now_playing_bar.dart';

class ShellScreen extends ConsumerStatefulWidget {
  const ShellScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends ConsumerState<ShellScreen> {
  static const _hintKey = 'webHintDismissed';
  bool _hideWebHint = false;

  @override
  void initState() {
    super.initState();
    _hideWebHint =
        ref.read(sharedPreferencesProvider).getBool(_hintKey) ?? false;
  }

  Future<void> _dismissHint() async {
    setState(() => _hideWebHint = true);
    await ref.read(sharedPreferencesProvider).setBool(_hintKey, true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final navigationShell = widget.navigationShell;
    final destinations = [
      _Nav(
        icon: Icons.timer_outlined,
        selectedIcon: Icons.timer,
        label: l10n.navHome,
      ),
      _Nav(
        icon: Icons.library_music_outlined,
        selectedIcon: Icons.library_music,
        label: l10n.navMusic,
      ),
      _Nav(
        icon: Icons.history,
        selectedIcon: Icons.history,
        label: l10n.navHistory,
      ),
      _Nav(
        icon: Icons.tune,
        selectedIcon: Icons.tune,
        label: l10n.navSettings,
      ),
    ];

    void go(int index) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    final content = Column(
      children: [
        if (kIsWeb && !_hideWebHint)
          Material(
            color: palette.surfaceHigh,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.webDemoHint,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: palette.textMuted,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.dismissHint,
                      onPressed: _dismissHint,
                      icon: const Icon(Icons.close, size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        Expanded(child: navigationShell),
        const NowPlayingBar(),
      ],
    );

    if (PulseLayout.isExpanded(context)) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: go,
              extended: MediaQuery.sizeOf(context).width >= 1100,
              labelType: MediaQuery.sizeOf(context).width >= 1100
                  ? NavigationRailLabelType.none
                  : NavigationRailLabelType.all,
              backgroundColor: palette.background,
              indicatorColor: palette.surfaceHigh,
              selectedIconTheme: IconThemeData(color: palette.accent),
              unselectedIconTheme: IconThemeData(color: palette.textMuted),
              selectedLabelTextStyle: TextStyle(
                color: palette.accent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              unselectedLabelTextStyle:
                  TextStyle(color: palette.textMuted, fontSize: 12),
              destinations: [
                for (final d in destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon, semanticLabel: d.label),
                    selectedIcon: Icon(d.selectedIcon, semanticLabel: d.label),
                    label: Text(d.label),
                  ),
              ],
            ),
            VerticalDivider(width: 1, color: palette.hairline),
            Expanded(child: content),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: content,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: go,
        destinations: [
          for (final d in destinations)
            NavigationDestination(
              icon: Icon(d.icon, semanticLabel: d.label),
              selectedIcon: Icon(d.selectedIcon, semanticLabel: d.label),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _Nav {
  const _Nav({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
