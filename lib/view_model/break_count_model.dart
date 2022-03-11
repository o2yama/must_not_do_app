import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';

final breakCountModelProvider =
    ChangeNotifierProvider.family.autoDispose((ref, Task task) {
  return BreakCountModel(
    task: task,
    db: ref.watch(dbProvider),
  )..setCountColor();
});

class BreakCountModel extends ChangeNotifier {
  BreakCountModel({required this.task, required this.db});

  final AppDatabase db;
  Task task;
  Color countColor = Colors.green;

  Future<void> decrementBreakCount() async {
    task = task.copyWith(breakCount: task.breakCount - 1);
    setCountColor();

    await db.updateTask(task);

    notifyListeners();
  }

  Future<void> incrementBreakCount() async {
    task = task.copyWith(breakCount: task.breakCount + 1);
    setCountColor();

    await db.updateTask(task);

    notifyListeners();
  }

  void setCountColor() {
    if (task.breakCount < 4) {
      countColor = Colors.green;
    } else if (task.breakCount < 7) {
      countColor = Colors.orange;
    } else {
      countColor = Colors.red;
    }

    notifyListeners();
  }
}
