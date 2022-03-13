import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view/common/loading_view.dart';
import 'package:no_todo_app/view_model/task_card_model.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(task.title + '\n削除してもよろしいですか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      ref.watch(loadingStateProvider.notifier).startLoading();

                      await ref
                          .watch(taskCardModelProvider)
                          .deleteTask(task.id);

                      ref.watch(loadingStateProvider.notifier).endLoading();

                      Navigator.pop(context);
                    },
                    child: const Text(
                      '削除',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ],
          )
        : AlertDialog(
            title: Text(task.title + '\n削除してもよろしいですか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル'),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      ref.watch(loadingStateProvider.notifier).startLoading();

                      await ref
                          .watch(taskCardModelProvider)
                          .deleteTask(task.id);

                      ref.watch(loadingStateProvider.notifier).endLoading();

                      Navigator.pop(context);
                    },
                    child: const Text(
                      '削除',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
