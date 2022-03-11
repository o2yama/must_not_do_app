import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view/components/task_dialog.dart';

final taskModelProvider = Provider.autoDispose(
  (ref) => TaskModel(db: ref.watch(dbProvider)),
);

class TaskModel {
  TaskModel({required this.db});

  final AppDatabase db;

  bool validateFields() {
    if (titleController.text.isEmpty) {
      return false;
    } else if (purposeController.text.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> storeTask(String title, String purpose, String detail) async {
    await db.insertTask(
      TasksCompanion(
        title: Value(title),
        purpose: Value(purpose),
        detail: Value(detail),
        createdAt: Value(DateTime.now()),
        updateAt: Value(DateTime.now()),
        breakCount: const Value(0),
      ),
    );
  }

  Future<void> updateTask(
    Task task,
    String title,
    String purpose,
    String detail,
  ) async {
    await db.updateTask(
      task.copyWith(
        title: title,
        purpose: purpose,
        detail: detail,
        updateAt: DateTime.now(),
      ),
    );
  }

  Future<void> deleteTask(int taskId) async {
    await db.deleteTask(taskId);
  }
}
