import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view/widgets/task_dialog.dart';

final taskModelProvider = StateNotifierProvider.autoDispose(
  (ref) => TaskModel(db: ref.watch(dbProvider)),
);

class TaskModel extends StateNotifier<Task?> {
  TaskModel({required this.db}) : super(null);

  final AppDatabase db;

  var isTodo = true;

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

  Future<void> addBreakCount(Task task) async {
    await db.updateTask(
      task.copyWith(
        breakCount: task.breakCount + 1,
        updateAt: DateTime.now(),
      ),
    );
  }
}
