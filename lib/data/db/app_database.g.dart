// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoutinesTable extends Routines with TableInfo<$RoutinesTable, Routine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepareSecondsMeta = const VerificationMeta(
    'prepareSeconds',
  );
  @override
  late final GeneratedColumn<int> prepareSeconds = GeneratedColumn<int>(
    'prepare_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workSecondsMeta = const VerificationMeta(
    'workSeconds',
  );
  @override
  late final GeneratedColumn<int> workSeconds = GeneratedColumn<int>(
    'work_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundsMeta = const VerificationMeta('rounds');
  @override
  late final GeneratedColumn<int> rounds = GeneratedColumn<int>(
    'rounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundRestSecondsMeta = const VerificationMeta(
    'roundRestSeconds',
  );
  @override
  late final GeneratedColumn<int> roundRestSeconds = GeneratedColumn<int>(
    'round_rest_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _exerciseLabelMeta = const VerificationMeta(
    'exerciseLabel',
  );
  @override
  late final GeneratedColumn<String> exerciseLabel = GeneratedColumn<String>(
    'exercise_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
    'playlist_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customSegmentsJsonMeta =
      const VerificationMeta('customSegmentsJson');
  @override
  late final GeneratedColumn<String> customSegmentsJson =
      GeneratedColumn<String>(
        'custom_segments_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isPresetMeta = const VerificationMeta(
    'isPreset',
  );
  @override
  late final GeneratedColumn<bool> isPreset = GeneratedColumn<bool>(
    'is_preset',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_preset" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    mode,
    prepareSeconds,
    workSeconds,
    restSeconds,
    rounds,
    roundRestSeconds,
    exerciseLabel,
    playlistId,
    customSegmentsJson,
    isPreset,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<Routine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('prepare_seconds')) {
      context.handle(
        _prepareSecondsMeta,
        prepareSeconds.isAcceptableOrUnknown(
          data['prepare_seconds']!,
          _prepareSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prepareSecondsMeta);
    }
    if (data.containsKey('work_seconds')) {
      context.handle(
        _workSecondsMeta,
        workSeconds.isAcceptableOrUnknown(
          data['work_seconds']!,
          _workSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workSecondsMeta);
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restSecondsMeta);
    }
    if (data.containsKey('rounds')) {
      context.handle(
        _roundsMeta,
        rounds.isAcceptableOrUnknown(data['rounds']!, _roundsMeta),
      );
    } else if (isInserting) {
      context.missing(_roundsMeta);
    }
    if (data.containsKey('round_rest_seconds')) {
      context.handle(
        _roundRestSecondsMeta,
        roundRestSeconds.isAcceptableOrUnknown(
          data['round_rest_seconds']!,
          _roundRestSecondsMeta,
        ),
      );
    }
    if (data.containsKey('exercise_label')) {
      context.handle(
        _exerciseLabelMeta,
        exerciseLabel.isAcceptableOrUnknown(
          data['exercise_label']!,
          _exerciseLabelMeta,
        ),
      );
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    }
    if (data.containsKey('custom_segments_json')) {
      context.handle(
        _customSegmentsJsonMeta,
        customSegmentsJson.isAcceptableOrUnknown(
          data['custom_segments_json']!,
          _customSegmentsJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_preset')) {
      context.handle(
        _isPresetMeta,
        isPreset.isAcceptableOrUnknown(data['is_preset']!, _isPresetMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Routine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Routine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      prepareSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prepare_seconds'],
      )!,
      workSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}work_seconds'],
      )!,
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      )!,
      rounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounds'],
      )!,
      roundRestSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}round_rest_seconds'],
      )!,
      exerciseLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_label'],
      ),
      playlistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}playlist_id'],
      ),
      customSegmentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_segments_json'],
      ),
      isPreset: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_preset'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RoutinesTable createAlias(String alias) {
    return $RoutinesTable(attachedDatabase, alias);
  }
}

class Routine extends DataClass implements Insertable<Routine> {
  final String id;
  final String name;
  final String mode;
  final int prepareSeconds;
  final int workSeconds;
  final int restSeconds;
  final int rounds;
  final int roundRestSeconds;
  final String? exerciseLabel;
  final String? playlistId;
  final String? customSegmentsJson;
  final bool isPreset;
  final DateTime updatedAt;
  const Routine({
    required this.id,
    required this.name,
    required this.mode,
    required this.prepareSeconds,
    required this.workSeconds,
    required this.restSeconds,
    required this.rounds,
    required this.roundRestSeconds,
    this.exerciseLabel,
    this.playlistId,
    this.customSegmentsJson,
    required this.isPreset,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['mode'] = Variable<String>(mode);
    map['prepare_seconds'] = Variable<int>(prepareSeconds);
    map['work_seconds'] = Variable<int>(workSeconds);
    map['rest_seconds'] = Variable<int>(restSeconds);
    map['rounds'] = Variable<int>(rounds);
    map['round_rest_seconds'] = Variable<int>(roundRestSeconds);
    if (!nullToAbsent || exerciseLabel != null) {
      map['exercise_label'] = Variable<String>(exerciseLabel);
    }
    if (!nullToAbsent || playlistId != null) {
      map['playlist_id'] = Variable<String>(playlistId);
    }
    if (!nullToAbsent || customSegmentsJson != null) {
      map['custom_segments_json'] = Variable<String>(customSegmentsJson);
    }
    map['is_preset'] = Variable<bool>(isPreset);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RoutinesCompanion toCompanion(bool nullToAbsent) {
    return RoutinesCompanion(
      id: Value(id),
      name: Value(name),
      mode: Value(mode),
      prepareSeconds: Value(prepareSeconds),
      workSeconds: Value(workSeconds),
      restSeconds: Value(restSeconds),
      rounds: Value(rounds),
      roundRestSeconds: Value(roundRestSeconds),
      exerciseLabel: exerciseLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseLabel),
      playlistId: playlistId == null && nullToAbsent
          ? const Value.absent()
          : Value(playlistId),
      customSegmentsJson: customSegmentsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customSegmentsJson),
      isPreset: Value(isPreset),
      updatedAt: Value(updatedAt),
    );
  }

  factory Routine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Routine(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mode: serializer.fromJson<String>(json['mode']),
      prepareSeconds: serializer.fromJson<int>(json['prepareSeconds']),
      workSeconds: serializer.fromJson<int>(json['workSeconds']),
      restSeconds: serializer.fromJson<int>(json['restSeconds']),
      rounds: serializer.fromJson<int>(json['rounds']),
      roundRestSeconds: serializer.fromJson<int>(json['roundRestSeconds']),
      exerciseLabel: serializer.fromJson<String?>(json['exerciseLabel']),
      playlistId: serializer.fromJson<String?>(json['playlistId']),
      customSegmentsJson: serializer.fromJson<String?>(
        json['customSegmentsJson'],
      ),
      isPreset: serializer.fromJson<bool>(json['isPreset']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'mode': serializer.toJson<String>(mode),
      'prepareSeconds': serializer.toJson<int>(prepareSeconds),
      'workSeconds': serializer.toJson<int>(workSeconds),
      'restSeconds': serializer.toJson<int>(restSeconds),
      'rounds': serializer.toJson<int>(rounds),
      'roundRestSeconds': serializer.toJson<int>(roundRestSeconds),
      'exerciseLabel': serializer.toJson<String?>(exerciseLabel),
      'playlistId': serializer.toJson<String?>(playlistId),
      'customSegmentsJson': serializer.toJson<String?>(customSegmentsJson),
      'isPreset': serializer.toJson<bool>(isPreset),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Routine copyWith({
    String? id,
    String? name,
    String? mode,
    int? prepareSeconds,
    int? workSeconds,
    int? restSeconds,
    int? rounds,
    int? roundRestSeconds,
    Value<String?> exerciseLabel = const Value.absent(),
    Value<String?> playlistId = const Value.absent(),
    Value<String?> customSegmentsJson = const Value.absent(),
    bool? isPreset,
    DateTime? updatedAt,
  }) => Routine(
    id: id ?? this.id,
    name: name ?? this.name,
    mode: mode ?? this.mode,
    prepareSeconds: prepareSeconds ?? this.prepareSeconds,
    workSeconds: workSeconds ?? this.workSeconds,
    restSeconds: restSeconds ?? this.restSeconds,
    rounds: rounds ?? this.rounds,
    roundRestSeconds: roundRestSeconds ?? this.roundRestSeconds,
    exerciseLabel: exerciseLabel.present
        ? exerciseLabel.value
        : this.exerciseLabel,
    playlistId: playlistId.present ? playlistId.value : this.playlistId,
    customSegmentsJson: customSegmentsJson.present
        ? customSegmentsJson.value
        : this.customSegmentsJson,
    isPreset: isPreset ?? this.isPreset,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Routine copyWithCompanion(RoutinesCompanion data) {
    return Routine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mode: data.mode.present ? data.mode.value : this.mode,
      prepareSeconds: data.prepareSeconds.present
          ? data.prepareSeconds.value
          : this.prepareSeconds,
      workSeconds: data.workSeconds.present
          ? data.workSeconds.value
          : this.workSeconds,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      rounds: data.rounds.present ? data.rounds.value : this.rounds,
      roundRestSeconds: data.roundRestSeconds.present
          ? data.roundRestSeconds.value
          : this.roundRestSeconds,
      exerciseLabel: data.exerciseLabel.present
          ? data.exerciseLabel.value
          : this.exerciseLabel,
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      customSegmentsJson: data.customSegmentsJson.present
          ? data.customSegmentsJson.value
          : this.customSegmentsJson,
      isPreset: data.isPreset.present ? data.isPreset.value : this.isPreset,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Routine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('prepareSeconds: $prepareSeconds, ')
          ..write('workSeconds: $workSeconds, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('rounds: $rounds, ')
          ..write('roundRestSeconds: $roundRestSeconds, ')
          ..write('exerciseLabel: $exerciseLabel, ')
          ..write('playlistId: $playlistId, ')
          ..write('customSegmentsJson: $customSegmentsJson, ')
          ..write('isPreset: $isPreset, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    mode,
    prepareSeconds,
    workSeconds,
    restSeconds,
    rounds,
    roundRestSeconds,
    exerciseLabel,
    playlistId,
    customSegmentsJson,
    isPreset,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Routine &&
          other.id == this.id &&
          other.name == this.name &&
          other.mode == this.mode &&
          other.prepareSeconds == this.prepareSeconds &&
          other.workSeconds == this.workSeconds &&
          other.restSeconds == this.restSeconds &&
          other.rounds == this.rounds &&
          other.roundRestSeconds == this.roundRestSeconds &&
          other.exerciseLabel == this.exerciseLabel &&
          other.playlistId == this.playlistId &&
          other.customSegmentsJson == this.customSegmentsJson &&
          other.isPreset == this.isPreset &&
          other.updatedAt == this.updatedAt);
}

class RoutinesCompanion extends UpdateCompanion<Routine> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> mode;
  final Value<int> prepareSeconds;
  final Value<int> workSeconds;
  final Value<int> restSeconds;
  final Value<int> rounds;
  final Value<int> roundRestSeconds;
  final Value<String?> exerciseLabel;
  final Value<String?> playlistId;
  final Value<String?> customSegmentsJson;
  final Value<bool> isPreset;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mode = const Value.absent(),
    this.prepareSeconds = const Value.absent(),
    this.workSeconds = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.rounds = const Value.absent(),
    this.roundRestSeconds = const Value.absent(),
    this.exerciseLabel = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.customSegmentsJson = const Value.absent(),
    this.isPreset = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutinesCompanion.insert({
    required String id,
    required String name,
    required String mode,
    required int prepareSeconds,
    required int workSeconds,
    required int restSeconds,
    required int rounds,
    this.roundRestSeconds = const Value.absent(),
    this.exerciseLabel = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.customSegmentsJson = const Value.absent(),
    this.isPreset = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       mode = Value(mode),
       prepareSeconds = Value(prepareSeconds),
       workSeconds = Value(workSeconds),
       restSeconds = Value(restSeconds),
       rounds = Value(rounds),
       updatedAt = Value(updatedAt);
  static Insertable<Routine> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? mode,
    Expression<int>? prepareSeconds,
    Expression<int>? workSeconds,
    Expression<int>? restSeconds,
    Expression<int>? rounds,
    Expression<int>? roundRestSeconds,
    Expression<String>? exerciseLabel,
    Expression<String>? playlistId,
    Expression<String>? customSegmentsJson,
    Expression<bool>? isPreset,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mode != null) 'mode': mode,
      if (prepareSeconds != null) 'prepare_seconds': prepareSeconds,
      if (workSeconds != null) 'work_seconds': workSeconds,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (rounds != null) 'rounds': rounds,
      if (roundRestSeconds != null) 'round_rest_seconds': roundRestSeconds,
      if (exerciseLabel != null) 'exercise_label': exerciseLabel,
      if (playlistId != null) 'playlist_id': playlistId,
      if (customSegmentsJson != null)
        'custom_segments_json': customSegmentsJson,
      if (isPreset != null) 'is_preset': isPreset,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? mode,
    Value<int>? prepareSeconds,
    Value<int>? workSeconds,
    Value<int>? restSeconds,
    Value<int>? rounds,
    Value<int>? roundRestSeconds,
    Value<String?>? exerciseLabel,
    Value<String?>? playlistId,
    Value<String?>? customSegmentsJson,
    Value<bool>? isPreset,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      prepareSeconds: prepareSeconds ?? this.prepareSeconds,
      workSeconds: workSeconds ?? this.workSeconds,
      restSeconds: restSeconds ?? this.restSeconds,
      rounds: rounds ?? this.rounds,
      roundRestSeconds: roundRestSeconds ?? this.roundRestSeconds,
      exerciseLabel: exerciseLabel ?? this.exerciseLabel,
      playlistId: playlistId ?? this.playlistId,
      customSegmentsJson: customSegmentsJson ?? this.customSegmentsJson,
      isPreset: isPreset ?? this.isPreset,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (prepareSeconds.present) {
      map['prepare_seconds'] = Variable<int>(prepareSeconds.value);
    }
    if (workSeconds.present) {
      map['work_seconds'] = Variable<int>(workSeconds.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (rounds.present) {
      map['rounds'] = Variable<int>(rounds.value);
    }
    if (roundRestSeconds.present) {
      map['round_rest_seconds'] = Variable<int>(roundRestSeconds.value);
    }
    if (exerciseLabel.present) {
      map['exercise_label'] = Variable<String>(exerciseLabel.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (customSegmentsJson.present) {
      map['custom_segments_json'] = Variable<String>(customSegmentsJson.value);
    }
    if (isPreset.present) {
      map['is_preset'] = Variable<bool>(isPreset.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mode: $mode, ')
          ..write('prepareSeconds: $prepareSeconds, ')
          ..write('workSeconds: $workSeconds, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('rounds: $rounds, ')
          ..write('roundRestSeconds: $roundRestSeconds, ')
          ..write('exerciseLabel: $exerciseLabel, ')
          ..write('playlistId: $playlistId, ')
          ..write('customSegmentsJson: $customSegmentsJson, ')
          ..write('isPreset: $isPreset, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(
    Insertable<Playlist> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final String id;
  final String name;
  final DateTime createdAt;
  const Playlist({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Playlist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Playlist copyWith({String? id, String? name, DateTime? createdAt}) =>
      Playlist(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  Playlist copyWithCompanion(PlaylistsCompanion data) {
    return Playlist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    required String id,
    required String name,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Playlist> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistTracksTable extends PlaylistTracks
    with TableInfo<$PlaylistTracksTable, PlaylistTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistTracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uriMeta = const VerificationMeta('uri');
  @override
  late final GeneratedColumn<String> uri = GeneratedColumn<String>(
    'uri',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playlistId,
    uri,
    title,
    artist,
    durationMs,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('uri')) {
      context.handle(
        _uriMeta,
        uri.isAcceptableOrUnknown(data['uri']!, _uriMeta),
      );
    } else if (isInserting) {
      context.missing(_uriMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistTrack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      playlistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}playlist_id'],
      )!,
      uri: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uri'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $PlaylistTracksTable createAlias(String alias) {
    return $PlaylistTracksTable(attachedDatabase, alias);
  }
}

class PlaylistTrack extends DataClass implements Insertable<PlaylistTrack> {
  final String id;
  final String playlistId;
  final String uri;
  final String title;
  final String artist;
  final int durationMs;
  final int sortOrder;
  const PlaylistTrack({
    required this.id,
    required this.playlistId,
    required this.uri,
    required this.title,
    required this.artist,
    required this.durationMs,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['playlist_id'] = Variable<String>(playlistId);
    map['uri'] = Variable<String>(uri);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['duration_ms'] = Variable<int>(durationMs);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PlaylistTracksCompanion toCompanion(bool nullToAbsent) {
    return PlaylistTracksCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      uri: Value(uri),
      title: Value(title),
      artist: Value(artist),
      durationMs: Value(durationMs),
      sortOrder: Value(sortOrder),
    );
  }

  factory PlaylistTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistTrack(
      id: serializer.fromJson<String>(json['id']),
      playlistId: serializer.fromJson<String>(json['playlistId']),
      uri: serializer.fromJson<String>(json['uri']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'playlistId': serializer.toJson<String>(playlistId),
      'uri': serializer.toJson<String>(uri),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'durationMs': serializer.toJson<int>(durationMs),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PlaylistTrack copyWith({
    String? id,
    String? playlistId,
    String? uri,
    String? title,
    String? artist,
    int? durationMs,
    int? sortOrder,
  }) => PlaylistTrack(
    id: id ?? this.id,
    playlistId: playlistId ?? this.playlistId,
    uri: uri ?? this.uri,
    title: title ?? this.title,
    artist: artist ?? this.artist,
    durationMs: durationMs ?? this.durationMs,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  PlaylistTrack copyWithCompanion(PlaylistTracksCompanion data) {
    return PlaylistTrack(
      id: data.id.present ? data.id.value : this.id,
      playlistId: data.playlistId.present
          ? data.playlistId.value
          : this.playlistId,
      uri: data.uri.present ? data.uri.value : this.uri,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTrack(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('uri: $uri, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('durationMs: $durationMs, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playlistId, uri, title, artist, durationMs, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistTrack &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.uri == this.uri &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.durationMs == this.durationMs &&
          other.sortOrder == this.sortOrder);
}

class PlaylistTracksCompanion extends UpdateCompanion<PlaylistTrack> {
  final Value<String> id;
  final Value<String> playlistId;
  final Value<String> uri;
  final Value<String> title;
  final Value<String> artist;
  final Value<int> durationMs;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const PlaylistTracksCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.uri = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistTracksCompanion.insert({
    required String id,
    required String playlistId,
    required String uri,
    required String title,
    this.artist = const Value.absent(),
    this.durationMs = const Value.absent(),
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       playlistId = Value(playlistId),
       uri = Value(uri),
       title = Value(title),
       sortOrder = Value(sortOrder);
  static Insertable<PlaylistTrack> custom({
    Expression<String>? id,
    Expression<String>? playlistId,
    Expression<String>? uri,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<int>? durationMs,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (uri != null) 'uri': uri,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (durationMs != null) 'duration_ms': durationMs,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistTracksCompanion copyWith({
    Value<String>? id,
    Value<String>? playlistId,
    Value<String>? uri,
    Value<String>? title,
    Value<String>? artist,
    Value<int>? durationMs,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return PlaylistTracksCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      uri: uri ?? this.uri,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      durationMs: durationMs ?? this.durationMs,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (uri.present) {
      map['uri'] = Variable<String>(uri.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTracksCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('uri: $uri, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('durationMs: $durationMs, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutHistoryTable extends WorkoutHistory
    with TableInfo<$WorkoutHistoryTable, WorkoutHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineNameMeta = const VerificationMeta(
    'routineName',
  );
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
    'routine_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    routineName,
    startedAt,
    endedAt,
    durationSeconds,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('routine_name')) {
      context.handle(
        _routineNameMeta,
        routineName.isAcceptableOrUnknown(
          data['routine_name']!,
          _routineNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      routineName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_name'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $WorkoutHistoryTable createAlias(String alias) {
    return $WorkoutHistoryTable(attachedDatabase, alias);
  }
}

class WorkoutHistoryData extends DataClass
    implements Insertable<WorkoutHistoryData> {
  final String id;
  final String routineId;
  final String routineName;
  final DateTime startedAt;
  final DateTime endedAt;
  final int durationSeconds;
  final bool completed;
  const WorkoutHistoryData({
    required this.id,
    required this.routineId,
    required this.routineName,
    required this.startedAt,
    required this.endedAt,
    required this.durationSeconds,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['routine_name'] = Variable<String>(routineName);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  WorkoutHistoryCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistoryCompanion(
      id: Value(id),
      routineId: Value(routineId),
      routineName: Value(routineName),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      durationSeconds: Value(durationSeconds),
      completed: Value(completed),
    );
  }

  factory WorkoutHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistoryData(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      routineName: serializer.fromJson<String>(json['routineName']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'routineName': serializer.toJson<String>(routineName),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  WorkoutHistoryData copyWith({
    String? id,
    String? routineId,
    String? routineName,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationSeconds,
    bool? completed,
  }) => WorkoutHistoryData(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    routineName: routineName ?? this.routineName,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    completed: completed ?? this.completed,
  );
  WorkoutHistoryData copyWithCompanion(WorkoutHistoryCompanion data) {
    return WorkoutHistoryData(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      routineName: data.routineName.present
          ? data.routineName.value
          : this.routineName,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistoryData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('routineName: $routineName, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    routineName,
    startedAt,
    endedAt,
    durationSeconds,
    completed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistoryData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.routineName == this.routineName &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.completed == this.completed);
}

class WorkoutHistoryCompanion extends UpdateCompanion<WorkoutHistoryData> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> routineName;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<int> durationSeconds;
  final Value<bool> completed;
  final Value<int> rowid;
  const WorkoutHistoryCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.routineName = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.completed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutHistoryCompanion.insert({
    required String id,
    required String routineId,
    required String routineName,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    required bool completed,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       routineName = Value(routineName),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       durationSeconds = Value(durationSeconds),
       completed = Value(completed);
  static Insertable<WorkoutHistoryData> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? routineName,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationSeconds,
    Expression<bool>? completed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (routineName != null) 'routine_name': routineName,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (completed != null) 'completed': completed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String>? routineName,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<int>? durationSeconds,
    Value<bool>? completed,
    Value<int>? rowid,
  }) {
    return WorkoutHistoryCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      routineName: routineName ?? this.routineName,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completed: completed ?? this.completed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistoryCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('routineName: $routineName, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoutinesTable routines = $RoutinesTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistTracksTable playlistTracks = $PlaylistTracksTable(this);
  late final $WorkoutHistoryTable workoutHistory = $WorkoutHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    routines,
    playlists,
    playlistTracks,
    workoutHistory,
  ];
}

typedef $$RoutinesTableCreateCompanionBuilder = RoutinesCompanion Function({
  required String id,
  required String name,
  required String mode,
  required int prepareSeconds,
  required int workSeconds,
  required int restSeconds,
  required int rounds,
  Value<int> roundRestSeconds,
  Value<String?> exerciseLabel,
  Value<String?> playlistId,
  Value<String?> customSegmentsJson,
  Value<bool> isPreset,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RoutinesTableUpdateCompanionBuilder = RoutinesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> mode,
  Value<int> prepareSeconds,
  Value<int> workSeconds,
  Value<int> restSeconds,
  Value<int> rounds,
  Value<int> roundRestSeconds,
  Value<String?> exerciseLabel,
  Value<String?> playlistId,
  Value<String?> customSegmentsJson,
  Value<bool> isPreset,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$RoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepareSeconds => $composableBuilder(
    column: $table.prepareSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workSeconds => $composableBuilder(
    column: $table.workSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rounds => $composableBuilder(
    column: $table.rounds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundRestSeconds => $composableBuilder(
    column: $table.roundRestSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseLabel => $composableBuilder(
    column: $table.exerciseLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customSegmentsJson => $composableBuilder(
    column: $table.customSegmentsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPreset => $composableBuilder(
    column: $table.isPreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepareSeconds => $composableBuilder(
    column: $table.prepareSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workSeconds => $composableBuilder(
    column: $table.workSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rounds => $composableBuilder(
    column: $table.rounds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundRestSeconds => $composableBuilder(
    column: $table.roundRestSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseLabel => $composableBuilder(
    column: $table.exerciseLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customSegmentsJson => $composableBuilder(
    column: $table.customSegmentsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPreset => $composableBuilder(
    column: $table.isPreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutinesTable> {
  $$RoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get prepareSeconds => $composableBuilder(
    column: $table.prepareSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workSeconds => $composableBuilder(
    column: $table.workSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rounds =>
      $composableBuilder(column: $table.rounds, builder: (column) => column);

  GeneratedColumn<int> get roundRestSeconds => $composableBuilder(
    column: $table.roundRestSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseLabel => $composableBuilder(
    column: $table.exerciseLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customSegmentsJson => $composableBuilder(
    column: $table.customSegmentsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPreset =>
      $composableBuilder(column: $table.isPreset, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutinesTable,
          Routine,
          $$RoutinesTableFilterComposer,
          $$RoutinesTableOrderingComposer,
          $$RoutinesTableAnnotationComposer,
          $$RoutinesTableCreateCompanionBuilder,
          $$RoutinesTableUpdateCompanionBuilder,
          (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
          Routine,
          PrefetchHooks Function()
        > {
  $$RoutinesTableTableManager(_$AppDatabase db, $RoutinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int> prepareSeconds = const Value.absent(),
                Value<int> workSeconds = const Value.absent(),
                Value<int> restSeconds = const Value.absent(),
                Value<int> rounds = const Value.absent(),
                Value<int> roundRestSeconds = const Value.absent(),
                Value<String?> exerciseLabel = const Value.absent(),
                Value<String?> playlistId = const Value.absent(),
                Value<String?> customSegmentsJson = const Value.absent(),
                Value<bool> isPreset = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion(
                id: id,
                name: name,
                mode: mode,
                prepareSeconds: prepareSeconds,
                workSeconds: workSeconds,
                restSeconds: restSeconds,
                rounds: rounds,
                roundRestSeconds: roundRestSeconds,
                exerciseLabel: exerciseLabel,
                playlistId: playlistId,
                customSegmentsJson: customSegmentsJson,
                isPreset: isPreset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String mode,
                required int prepareSeconds,
                required int workSeconds,
                required int restSeconds,
                required int rounds,
                Value<int> roundRestSeconds = const Value.absent(),
                Value<String?> exerciseLabel = const Value.absent(),
                Value<String?> playlistId = const Value.absent(),
                Value<String?> customSegmentsJson = const Value.absent(),
                Value<bool> isPreset = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RoutinesCompanion.insert(
                id: id,
                name: name,
                mode: mode,
                prepareSeconds: prepareSeconds,
                workSeconds: workSeconds,
                restSeconds: restSeconds,
                rounds: rounds,
                roundRestSeconds: roundRestSeconds,
                exerciseLabel: exerciseLabel,
                playlistId: playlistId,
                customSegmentsJson: customSegmentsJson,
                isPreset: isPreset,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutinesTable,
      Routine,
      $$RoutinesTableFilterComposer,
      $$RoutinesTableOrderingComposer,
      $$RoutinesTableAnnotationComposer,
      $$RoutinesTableCreateCompanionBuilder,
      $$RoutinesTableUpdateCompanionBuilder,
      (Routine, BaseReferences<_$AppDatabase, $RoutinesTable, Routine>),
      Routine,
      PrefetchHooks Function()
    >;
typedef $$PlaylistsTableCreateCompanionBuilder = PlaylistsCompanion Function({
  required String id,
  required String name,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PlaylistsTableUpdateCompanionBuilder = PlaylistsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PlaylistsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlaylistsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaylistsTable,
          Playlist,
          $$PlaylistsTableFilterComposer,
          $$PlaylistsTableOrderingComposer,
          $$PlaylistsTableAnnotationComposer,
          $$PlaylistsTableCreateCompanionBuilder,
          $$PlaylistsTableUpdateCompanionBuilder,
          (Playlist, BaseReferences<_$AppDatabase, $PlaylistsTable, Playlist>),
          Playlist,
          PrefetchHooks Function()
        > {
  $$PlaylistsTableTableManager(_$AppDatabase db, $PlaylistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaylistsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaylistsTable,
      Playlist,
      $$PlaylistsTableFilterComposer,
      $$PlaylistsTableOrderingComposer,
      $$PlaylistsTableAnnotationComposer,
      $$PlaylistsTableCreateCompanionBuilder,
      $$PlaylistsTableUpdateCompanionBuilder,
      (Playlist, BaseReferences<_$AppDatabase, $PlaylistsTable, Playlist>),
      Playlist,
      PrefetchHooks Function()
    >;
typedef $$PlaylistTracksTableCreateCompanionBuilder =
    PlaylistTracksCompanion Function({
      required String id,
      required String playlistId,
      required String uri,
      required String title,
      Value<String> artist,
      Value<int> durationMs,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$PlaylistTracksTableUpdateCompanionBuilder =
    PlaylistTracksCompanion Function({
      Value<String> id,
      Value<String> playlistId,
      Value<String> uri,
      Value<String> title,
      Value<String> artist,
      Value<int> durationMs,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$PlaylistTracksTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistTracksTable> {
  $$PlaylistTracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlaylistTracksTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistTracksTable> {
  $$PlaylistTracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uri => $composableBuilder(
    column: $table.uri,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlaylistTracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistTracksTable> {
  $$PlaylistTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playlistId => $composableBuilder(
    column: $table.playlistId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uri =>
      $composableBuilder(column: $table.uri, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$PlaylistTracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaylistTracksTable,
          PlaylistTrack,
          $$PlaylistTracksTableFilterComposer,
          $$PlaylistTracksTableOrderingComposer,
          $$PlaylistTracksTableAnnotationComposer,
          $$PlaylistTracksTableCreateCompanionBuilder,
          $$PlaylistTracksTableUpdateCompanionBuilder,
          (
            PlaylistTrack,
            BaseReferences<_$AppDatabase, $PlaylistTracksTable, PlaylistTrack>,
          ),
          PlaylistTrack,
          PrefetchHooks Function()
        > {
  $$PlaylistTracksTableTableManager(
    _$AppDatabase db,
    $PlaylistTracksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistTracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> playlistId = const Value.absent(),
                Value<String> uri = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> artist = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaylistTracksCompanion(
                id: id,
                playlistId: playlistId,
                uri: uri,
                title: title,
                artist: artist,
                durationMs: durationMs,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String playlistId,
                required String uri,
                required String title,
                Value<String> artist = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => PlaylistTracksCompanion.insert(
                id: id,
                playlistId: playlistId,
                uri: uri,
                title: title,
                artist: artist,
                durationMs: durationMs,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlaylistTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaylistTracksTable,
      PlaylistTrack,
      $$PlaylistTracksTableFilterComposer,
      $$PlaylistTracksTableOrderingComposer,
      $$PlaylistTracksTableAnnotationComposer,
      $$PlaylistTracksTableCreateCompanionBuilder,
      $$PlaylistTracksTableUpdateCompanionBuilder,
      (
        PlaylistTrack,
        BaseReferences<_$AppDatabase, $PlaylistTracksTable, PlaylistTrack>,
      ),
      PlaylistTrack,
      PrefetchHooks Function()
    >;
typedef $$WorkoutHistoryTableCreateCompanionBuilder =
    WorkoutHistoryCompanion Function({
      required String id,
      required String routineId,
      required String routineName,
      required DateTime startedAt,
      required DateTime endedAt,
      required int durationSeconds,
      required bool completed,
      Value<int> rowid,
    });
typedef $$WorkoutHistoryTableUpdateCompanionBuilder =
    WorkoutHistoryCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String> routineName,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<int> durationSeconds,
      Value<bool> completed,
      Value<int> rowid,
    });

class $$WorkoutHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$WorkoutHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutHistoryTable,
          WorkoutHistoryData,
          $$WorkoutHistoryTableFilterComposer,
          $$WorkoutHistoryTableOrderingComposer,
          $$WorkoutHistoryTableAnnotationComposer,
          $$WorkoutHistoryTableCreateCompanionBuilder,
          $$WorkoutHistoryTableUpdateCompanionBuilder,
          (
            WorkoutHistoryData,
            BaseReferences<
              _$AppDatabase,
              $WorkoutHistoryTable,
              WorkoutHistoryData
            >,
          ),
          WorkoutHistoryData,
          PrefetchHooks Function()
        > {
  $$WorkoutHistoryTableTableManager(
    _$AppDatabase db,
    $WorkoutHistoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> routineName = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistoryCompanion(
                id: id,
                routineId: routineId,
                routineName: routineName,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                completed: completed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required String routineName,
                required DateTime startedAt,
                required DateTime endedAt,
                required int durationSeconds,
                required bool completed,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutHistoryCompanion.insert(
                id: id,
                routineId: routineId,
                routineName: routineName,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                completed: completed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutHistoryTable,
      WorkoutHistoryData,
      $$WorkoutHistoryTableFilterComposer,
      $$WorkoutHistoryTableOrderingComposer,
      $$WorkoutHistoryTableAnnotationComposer,
      $$WorkoutHistoryTableCreateCompanionBuilder,
      $$WorkoutHistoryTableUpdateCompanionBuilder,
      (
        WorkoutHistoryData,
        BaseReferences<_$AppDatabase, $WorkoutHistoryTable, WorkoutHistoryData>,
      ),
      WorkoutHistoryData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db, _db.routines);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistTracksTableTableManager get playlistTracks =>
      $$PlaylistTracksTableTableManager(_db, _db.playlistTracks);
  $$WorkoutHistoryTableTableManager get workoutHistory =>
      $$WorkoutHistoryTableTableManager(_db, _db.workoutHistory);
}
