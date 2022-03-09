import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';

final taskModelProvider = StateNotifierProvider.autoDispose(
  (ref) => TaskModel(db: ref.watch(dbProvider)),
);

class TaskModel extends StateNotifier<Task?> {
  TaskModel({required this.db}) : super(null);

  final AppDatabase db;

  var isTodo = true;

  String? validateField(String title, String detail) {
    if (title.isEmpty) {
      return 'タスクの名前を決めてください。';
    }

    return null;
  }

  Future<void> storeTask(String title, String detail, bool isTodo) async {
    await db.insertTask(
      TasksCompanion(
        title: Value(title),
        detail: Value(detail),
        isTodo: Value(isTodo),
      ),
    );
  }

  Future<void> updateTask(Task task) async {
    await db.updateTask(task);
  }

  Future<void> deleteTask(int taskId) async {
    await db.deleteTask(taskId);
  }
}
