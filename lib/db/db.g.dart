// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String title;
  final String? detail;
  final bool isTodo;
  Task(
      {required this.id,
      required this.title,
      this.detail,
      required this.isTodo});
  factory Task.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Task(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      detail: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}detail']),
      isTodo: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_todo'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String?>(detail);
    }
    map['is_todo'] = Variable<bool>(isTodo);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      detail:
          detail == null && nullToAbsent ? const Value.absent() : Value(detail),
      isTodo: Value(isTodo),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String?>(json['detail']),
      isTodo: serializer.fromJson<bool>(json['isTodo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String?>(detail),
      'isTodo': serializer.toJson<bool>(isTodo),
    };
  }

  Task copyWith({int? id, String? title, String? detail, bool? isTodo}) => Task(
        id: id ?? this.id,
        title: title ?? this.title,
        detail: detail ?? this.detail,
        isTodo: isTodo ?? this.isTodo,
      );
  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('isTodo: $isTodo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, detail, isTodo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.isTodo == this.isTodo);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> detail;
  final Value<bool> isTodo;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.isTodo = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.detail = const Value.absent(),
    required bool isTodo,
  })  : title = Value(title),
        isTodo = Value(isTodo);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String?>? detail,
    Expression<bool>? isTodo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (isTodo != null) 'is_todo': isTodo,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? detail,
      Value<bool>? isTodo}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      isTodo: isTodo ?? this.isTodo,
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
    if (detail.present) {
      map['detail'] = Variable<String?>(detail.value);
    }
    if (isTodo.present) {
      map['is_todo'] = Variable<bool>(isTodo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('isTodo: $isTodo')
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
  final VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String?> detail = GeneratedColumn<String?>(
      'detail', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _isTodoMeta = const VerificationMeta('isTodo');
  @override
  late final GeneratedColumn<bool?> isTodo = GeneratedColumn<bool?>(
      'is_todo', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_todo IN (0, 1))');
  @override
  List<GeneratedColumn> get $columns => [id, title, detail, isTodo];
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
    if (data.containsKey('detail')) {
      context.handle(_detailMeta,
          detail.isAcceptableOrUnknown(data['detail']!, _detailMeta));
    }
    if (data.containsKey('is_todo')) {
      context.handle(_isTodoMeta,
          isTodo.isAcceptableOrUnknown(data['is_todo']!, _isTodoMeta));
    } else if (isInserting) {
      context.missing(_isTodoMeta);
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
