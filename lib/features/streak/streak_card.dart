import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/streak.dart';
import '../../l10n/generated/app_localizations.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key, required this.stats, this.onTap});

  final StreakStats stats;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final headline = stats.todayDone
        ? l10n.streakTodayDone
        : (stats.current > 0 ? l10n.streakTodayTodo : l10n.streakStartToday);
    return Material(
      color: palette.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: stats.current > 0 || stats.todayDone
                        ? palette.accent
                        : palette.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.streakLabel,
                    style: TextStyle(
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                      color: palette.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    l10n.streakLongest(stats.longest),
                    style: TextStyle(color: palette.textMuted, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.streakDays(stats.current),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(headline, style: TextStyle(color: palette.textMuted)),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (var i = 0; i < stats.last7.length; i++)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: i == stats.last7.length - 1 ? 0 : 6,
                        ),
                        height: 10,
                        decoration: BoxDecoration(
                          color: stats.last7[i]
                              ? palette.accent
                              : palette.surfaceHigh,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '${l10n.streakWeek(stats.weekSessions)}  ·  ${l10n.streakMinutes(stats.weekSeconds ~/ 60)}',
                style: TextStyle(color: palette.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
