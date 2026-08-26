import 'dart:convert';

import '../core/models/phase.dart';
import '../core/models/workout_plan.dart';
import '../data/repositories/routine_repository.dart';
import '../features/music/device_library.dart';

class CoachRoutine {
  const CoachRoutine({
    required this.spec,
    this.note = '',
    this.dayLabel = '',
  });

  final RoutineSpec spec;
  final String note;
  final String dayLabel;
}

class PlaylistPick {
  const PlaylistPick({required this.name, required this.songs});

  final String name;
  final List<DeviceSong> songs;
}

Map<String, dynamic> decodeCoachJson(String raw) {
  var text = raw.trim();
  if (text.startsWith('```')) {
    text = text
        .replaceAll(RegExp(r'^```(?:json)?'), '')
        .replaceAll('```', '')
        .trim();
  }
  final decoded = jsonDecode(text);
  if (decoded is Map<String, dynamic>) return decoded;
  if (decoded is Map) return Map<String, dynamic>.from(decoded);
  if (decoded is List) return {'routines': decoded};
  return {};
}

int coachInt(Object? value, int fallback) {
  if (value is int) return value;
  if (value is num) return value.round();
  return int.tryParse('$value') ?? fallback;
}

List<CoachRoutine> parseCoachRoutines(String raw) {
  final json = decodeCoachJson(raw);
  final list = json['routines'];
  if (list is! List) return const [];
  final out = <CoachRoutine>[];
  for (final item in list) {
    if (item is! Map) continue;
    final map = Map<String, dynamic>.from(item);
    final modeName = '${map['mode'] ?? 'series'}';
    final mode = WorkoutMode.values.firstWhere(
      (m) => m.name == modeName,
      orElse: () => WorkoutMode.series,
    );
    final custom = <CustomSegment>[];
    final customRaw = map['custom'];
    if (customRaw is List) {
      for (final seg in customRaw) {
        if (seg is! Map) continue;
        final sm = Map<String, dynamic>.from(seg);
        custom.add(
          CustomSegment(
            kind: sm['kind'] == 'rest' ? PhaseKind.rest : PhaseKind.work,
            seconds: coachInt(sm['seconds'], 30).clamp(5, 30 * 60),
            label: '${sm['label'] ?? ''}',
          ),
        );
      }
    }
    final name = '${map['name'] ?? ''}'.trim();
    out.add(
      CoachRoutine(
        dayLabel: '${map['day'] ?? ''}'.trim(),
        note: '${map['note'] ?? ''}'.trim(),
        spec: RoutineSpec(
          id: RoutineRepository.newId(),
          name: name.isEmpty ? 'Lejos' : name,
          mode: mode,
          prepareSeconds: coachInt(map['prepareSeconds'], 10).clamp(0, 60),
          workSeconds: coachInt(map['workSeconds'], 40).clamp(5, 30 * 60),
          restSeconds: coachInt(map['restSeconds'], 20).clamp(0, 10 * 60),
          rounds: coachInt(map['rounds'], 8).clamp(1, 40),
          exerciseLabel: '${map['exerciseLabel'] ?? ''}'.trim().isEmpty
              ? null
              : '${map['exerciseLabel']}'.trim(),
          custom: custom,
        ),
      ),
    );
  }
  return out;
}

PlaylistPick parsePlaylistPick(String raw, List<DeviceSong> catalog) {
  final json = decodeCoachJson(raw);
  final name = (json['name'] as String?)?.trim();
  final songs = <DeviceSong>[];
  final rawIndices = json['indices'];
  if (rawIndices is List) {
    for (final item in rawIndices) {
      final i = item is int ? item : int.tryParse('$item');
      if (i == null || i < 0 || i >= catalog.length) continue;
      songs.add(catalog[i]);
    }
  }
  return PlaylistPick(
    name: (name == null || name.isEmpty) ? 'Lejos mix' : name,
    songs: songs,
  );
}

bool isLikelyMusic(DeviceSong song) => song.isLikelyMusic;
