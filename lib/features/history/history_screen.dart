import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/format.dart';
import '../../l10n/generated/app_localizations.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(historyProvider);

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
          return PulsePage(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.separated(
              itemCount: rows.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final row = rows[i];
                return ListTile(
                  title: Text(row.routineName),
                  subtitle: Text(
                    '${row.completed ? l10n.historyCompleted : l10n.historyStopped}  ·  ${TimeFormat.pretty(Duration(seconds: row.durationSeconds))}',
                    style: TextStyle(color: context.pulse.textMuted),
                  ),
                  trailing: Text(
                    '${row.endedAt.day.toString().padLeft(2, '0')}/${row.endedAt.month.toString().padLeft(2, '0')}',
                    style: TextStyle(color: context.pulse.textMuted),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
