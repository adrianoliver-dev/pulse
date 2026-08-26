import 'phase.dart';

class WorkoutSegment {
  const WorkoutSegment({
    required this.kind,
    required this.duration,
    required this.label,
    required this.roundIndex,
    required this.roundCount,
    required this.workIndex,
    required this.workCount,
  });

  final PhaseKind kind;
  final Duration duration;
  final String label;
  final int roundIndex;
  final int roundCount;
  final int workIndex;
  final int workCount;
}

class WorkoutPlan {
  const WorkoutPlan({
    required this.id,
    required this.name,
    required this.segments,
    this.playlistId,
  });

  final String id;
  final String name;
  final List<WorkoutSegment> segments;
  final String? playlistId;

  Duration get totalDuration =>
      segments.fold(Duration.zero, (sum, s) => sum + s.duration);

  int get workCount => segments.where((s) => s.kind == PhaseKind.work).length;
}

class CustomSegment {
  const CustomSegment({
    required this.kind,
    required this.seconds,
    this.label = '',
  });

  final PhaseKind kind;
  final int seconds;
  final String label;

  Map<String, dynamic> toJson() => {
        'kind': kind.name,
        'seconds': seconds,
        'label': label,
      };

  factory CustomSegment.fromJson(Map<String, dynamic> json) {
    return CustomSegment(
      kind: PhaseKind.values.firstWhere(
        (k) => k.name == json['kind'],
        orElse: () => PhaseKind.work,
      ),
      seconds: (json['seconds'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
    );
  }
}

class RoutineSpec {
  const RoutineSpec({
    required this.id,
    required this.name,
    required this.mode,
    this.prepareSeconds = 10,
    this.workSeconds = 60,
    this.restSeconds = 30,
    this.rounds = 3,
    this.roundRestSeconds = 0,
    this.exerciseLabel,
    this.playlistId,
    this.custom = const [],
    this.isPreset = false,
    this.updatedAt,
  });

  final String id;
  final String name;
  final WorkoutMode mode;
  final int prepareSeconds;
  final int workSeconds;
  final int restSeconds;
  final int rounds;
  final int roundRestSeconds;
  final String? exerciseLabel;
  final String? playlistId;
  final List<CustomSegment> custom;
  final bool isPreset;
  final DateTime? updatedAt;

  RoutineSpec copyWith({
    String? id,
    String? name,
    WorkoutMode? mode,
    int? prepareSeconds,
    int? workSeconds,
    int? restSeconds,
    int? rounds,
    int? roundRestSeconds,
    String? exerciseLabel,
    String? playlistId,
    List<CustomSegment>? custom,
    bool? isPreset,
    DateTime? updatedAt,
    bool clearPlaylist = false,
  }) {
    return RoutineSpec(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      prepareSeconds: prepareSeconds ?? this.prepareSeconds,
      workSeconds: workSeconds ?? this.workSeconds,
      restSeconds: restSeconds ?? this.restSeconds,
      rounds: rounds ?? this.rounds,
      roundRestSeconds: roundRestSeconds ?? this.roundRestSeconds,
      exerciseLabel: exerciseLabel ?? this.exerciseLabel,
      playlistId: clearPlaylist ? null : (playlistId ?? this.playlistId),
      custom: custom ?? this.custom,
      isPreset: isPreset ?? this.isPreset,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
