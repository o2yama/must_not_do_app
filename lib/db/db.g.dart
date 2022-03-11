// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String purpose;
  final String? detail;
  final DateTime createdAt;
  final DateTime updateAt;
  final int breakCount;
  Task(
      {required this.id,
      required this.title,
      required this.purpose,
      this.detail,
      required this.createdAt,
      required this.updateAt,
      required this.breakCount});
  factory Task.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      purpose: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}purpose'])!,
      detail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}detail']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updateAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}update_at'])!,
      breakCount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}break_count'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['purpose'] = Variable<String>(purpose);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String?>(detail);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['update_at'] = Variable<DateTime>(updateAt);
    map['break_count'] = Variable<int>(breakCount);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      purpose: Value(purpose),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
      createdAt: Value(createdAt),
      updateAt: Value(updateAt),
      breakCount: Value(breakCount),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      purpose: serializer.fromJson<String>(json['purpose']),
      detail: serializer.fromJson<String?>(json['detail']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updateAt: serializer.fromJson<DateTime>(json['updateAt']),
      breakCount: serializer.fromJson<int>(json['breakCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'purpose': serializer.toJson<String>(purpose),
      'detail': serializer.toJson<String?>(detail),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updateAt': serializer.toJson<DateTime>(updateAt),
      'breakCount': serializer.toJson<int>(breakCount),
    };
  }

  Task copyWith(
          {int? id,
          String? title,
          String? purpose,
          String? detail,
          DateTime? createdAt,
          DateTime? updateAt,
          int? breakCount}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        purpose: purpose ?? this.purpose,
        detail: detail ?? this.detail,
        createdAt: createdAt ?? this.createdAt,
        updateAt: updateAt ?? this.updateAt,
        breakCount: breakCount ?? this.breakCount,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('detail: $detail, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('breakCount: $breakCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, purpose, detail, createdAt, updateAt, breakCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.purpose == this.purpose &&
          other.detail == this.detail &&
          other.createdAt == this.createdAt &&
          other.updateAt == this.updateAt &&
          other.breakCount == this.breakCount);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> purpose;
  final Value<String?> detail;
  final Value<DateTime> createdAt;
  final Value<DateTime> updateAt;
  final Value<int> breakCount;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.purpose = const Value.absent(),
    this.detail = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.breakCount = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String purpose,
    this.detail = const Value.absent(),
    required DateTime createdAt,
    required DateTime updateAt,
    this.breakCount = const Value.absent(),
  })  : title = Value(title),
        purpose = Value(purpose),
        createdAt = Value(createdAt),
        updateAt = Value(updateAt);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? purpose,
    Expression<String?>? detail,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updateAt,
    Expression<int>? breakCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (purpose != null) 'purpose': purpose,
      if (detail != null) 'detail': detail,
      if (createdAt != null) 'created_at': createdAt,
      if (updateAt != null) 'update_at': updateAt,
      if (breakCount != null) 'break_count': breakCount,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? purpose,
      Value<String?>? detail,
      Value<DateTime>? createdAt,
      Value<DateTime>? updateAt,
      Value<int>? breakCount}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      purpose: purpose ?? this.purpose,
      detail: detail ?? this.detail,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      breakCount: breakCount ?? this.breakCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (purpose.present) {
      map['purpose'] = Variable<String>(purpose.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String?>(detail.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<DateTime>(updateAt.value);
    }
    if (breakCount.present) {
      map['break_count'] = Variable<int>(breakCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('purpose: $purpose, ')
          ..write('detail: $detail, ')
          ..write('createdAt: $createdAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('breakCount: $breakCount')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _purposeMeta = const VerificationMeta('purpose');
  @override
  late final GeneratedColumn<String?> purpose =
      GeneratedColumn<String?>('purpose', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String?> detail = GeneratedColumn<String?>(
      'detail', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _updateAtMeta = const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<DateTime?> updateAt = GeneratedColumn<DateTime?>(
      'update_at', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _breakCountMeta = const VerificationMeta('breakCount');
  @override
  late final GeneratedColumn<int?> breakCount = GeneratedColumn<int?>(
      'break_count', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, purpose, detail, createdAt, updateAt, breakCount];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('purpose')) {
      context.handle(_purposeMeta,
          purpose.isAcceptableOrUnknown(data['purpose']!, _purposeMeta));
    } else if (isInserting) {
      context.missing(_purposeMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    } else if (isInserting) {
      context.missing(_updateAtMeta);
    }
    if (data.containsKey('break_count')) {
      context.handle(
          _breakCountMeta,
          breakCount.isAcceptableOrUnknown(
              data['break_count']!, _breakCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Task.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TasksTable tasks = $TasksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks];
}
