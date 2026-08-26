import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/format.dart';
import '../../core/streak.dart';
import '../../data/db/app_database.dart';
import '../../l10n/generated/app_localizations.dart';
import '../library/routine_labels.dart';
import '../streak/streak_card.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(historyProvider);
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHistory)),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (rows) {
          if (rows.isEmpty) {
            return EmptyState(
              icon: Icons.history,
              title: l10n.noHistory,
              body: l10n.emptyHistoryBody,
            );
          }
          final stats = StreakStats.fromEvents(
            rows.map(
              (r) => StreakEvent(
                endedAt: r.endedAt,
                completed: r.completed,
                durationSeconds: r.durationSeconds,
              ),
            ),
          );
          final groups = _group(rows);
          return PulsePage(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: StreakCard(stats: stats),
                ),
                for (final group in groups) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
                    child: Text(
                      _dayLabel(group.$1, l10n, locale),
                      style: TextStyle(
                        color: context.pulse.textMuted,
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  for (final row in group.$2)
                    ListTile(
                      title: Text(
                        localizedNameForId(row.routineId, row.routineName, l10n),
                      ),
                      subtitle: Text(
                        '${row.completed ? l10n.historyCompleted : l10n.historyStopped}  ·  ${TimeFormat.pretty(Duration(seconds: row.durationSeconds))}',
                        style: TextStyle(color: context.pulse.textMuted),
                      ),
                      trailing: IconButton(
                        tooltip: l10n.historyRepeat,
                        icon: const Icon(Icons.replay),
                        onPressed: () =>
                            context.push('/workout/${row.routineId}'),
                      ),
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<(DateTime, List<WorkoutHistoryData>)> _group(
    List<WorkoutHistoryData> rows,
  ) {
    final map = <DateTime, List<WorkoutHistoryData>>{};
    for (final row in rows) {
      final local = row.endedAt.toLocal();
      final day = DateTime(local.year, local.month, local.day);
      map.putIfAbsent(day, () => []).add(row);
    }
    final keys = map.keys.toList()..sort((a, b) => b.compareTo(a));
    return [for (final k in keys) (k, map[k]!)];
  }

  String _dayLabel(DateTime day, AppLocalizations l10n, String locale) {
    final today = DateTime.now();
    final todayDay = DateTime(today.year, today.month, today.day);
    final yesterday = todayDay.subtract(const Duration(days: 1));
    if (day == todayDay) return l10n.dayToday;
    if (day == yesterday) return l10n.dayYesterday;
    return DateFormat.MMMEd(locale).format(day);
  }
}
