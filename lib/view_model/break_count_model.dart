import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';

final breakCountModelProvider =
    ChangeNotifierProvider.family.autoDispose((ref, Task task) {
  return BreakCountModel(
    task: task,
    db: ref.watch(dbProvider),
  )..setCountColor(task.detail);
});

class BreakCountModel extends ChangeNotifier {
  BreakCountModel({required this.task, required this.db});

  final AppDatabase db;
  Task task;
  Color countColor = Colors.green;
  String msg = 'ナイス継続！';

  Future<void> decrementBreakCount() async {
    task = task.copyWith(breakCount: task.breakCount - 1);
    setCountColor(task.detail);

    await db.updateTask(task);

    notifyListeners();
  }

  Future<void> incrementBreakCount() async {
    task = task.copyWith(breakCount: task.breakCount + 1);
    setCountColor(task.detail);

    await db.updateTask(task);

    notifyListeners();
  }

  void setCountColor(String? alternative) {
    if (task.breakCount < 4) {
      countColor = Colors.green;
      msg = 'ナイス継続！！';
    } else if (task.breakCount < 7) {
      countColor = Colors.orange;
      msg = 'もうちょっと頑張って！！';
    } else {
      countColor = Colors.red;
      msg =
          alternative == null ? '置き換え術を設定してみよう!' : '$alternative\n置き換え術を活用しよう！';
    }

    notifyListeners();
  }
}
