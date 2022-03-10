import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:no_todo_app/db/tables/tasks.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'db.g.dart';

final dbProvider = Provider.autoDispose((ref) => AppDatabase());

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Task>> watchTasks() => select(tasks).watch();

  Future<void> insertTask(TasksCompanion task) async {
    await into(tasks).insert(task);
  }

  Future<void> updateTask(Task task) async {
    await update(tasks).replace(task);
  }

  Future<void> deleteTask(int taskId) async {
    await (delete(tasks)..where((data) => data.id.equals(taskId))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
