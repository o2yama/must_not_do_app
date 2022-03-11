import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';

final taskCardModelProvider = ChangeNotifierProvider.family.autoDispose(
  (ref, Task task) => TaskCardModel(
    task: task,
    db: ref.watch(dbProvider),
  )..watchCountColor(),
);

class TaskCardModel extends ChangeNotifier {
  TaskCardModel({required this.task, required this.db});

  Task task;
  Color countColor = Colors.redAccent;
  final AppDatabase db;

  void watchCountColor() {
    Stream.periodic(
      const Duration(milliseconds: 1),
      (s) {
        if (task.breakCount < 3) {
          countColor = Colors.blue;
        } else if (task.breakCount < 7) {
          countColor = Colors.orange;
        } else {
          countColor = Colors.redAccent;
        }

        notifyListeners();
      },
    );
  }

  Future<void> decrementBreakCount(Task task) async {
    await db.updateTask(task.copyWith(breakCount: task.breakCount - 1));
  }

  Future<void> incrementBreakCount(Task task) async {
    await db.updateTask(task.copyWith(breakCount: task.breakCount + 1));
  }
}
