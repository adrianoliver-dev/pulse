import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../l10n/generated/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pages = PageController();
  int _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final slides = [
      (Icons.timer, l10n.onboarding1Title, l10n.onboarding1Body),
      (Icons.library_music, l10n.onboarding2Title, l10n.onboarding2Body),
      (Icons.local_fire_department_rounded, l10n.onboarding3Title, l10n.onboarding3Body),
      (Icons.auto_awesome, l10n.onboarding4Title, l10n.onboarding4Body),
    ];
    final last = _index == slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'LEJOS',
                    style: TextStyle(
                      letterSpacing: 4,
                      fontWeight: FontWeight.w700,
                      color: palette.accent,
                    ),
                  ),
                  const Spacer(),
                  if (!last)
                    TextButton(
                      onPressed: widget.onFinished,
                      child: Text(l10n.onboardingSkip),
                    ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pages,
                  itemCount: slides.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final slide = slides[i];
                    return Padding(
                      padding: const EdgeInsets.only(top: 36),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: palette.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(slide.$1, color: palette.accent, size: 32),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            slide.$2,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide.$3,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.45,
                              color: palette.textMuted,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < slides.length; i++)
                    Container(
                      width: i == _index ? 22 : 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: i == _index ? palette.accent : palette.surfaceHigh,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (last) {
                    widget.onFinished();
                    return;
                  }
                  _pages.nextPage(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOut,
                  );
                },
                child: Text(last ? l10n.onboardingStart : l10n.onboardingNext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
