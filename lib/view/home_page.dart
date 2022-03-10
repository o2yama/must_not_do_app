import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/utils/formatter.dart';
import 'package:no_todo_app/view/widgets/task_dialog.dart';
import 'package:no_todo_app/view_model/task_card_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        title: Image.asset(
          'assets/images/logo.png',
          width: 90,
          fit: BoxFit.fitWidth,
        ),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: Consumer(
          builder: (context, ref, child) {
            final _db = ref.watch(dbProvider);

            return StreamBuilder<List<Task>>(
              stream: _db.watchTasks(),
              builder: (context, snapshot) {
                return _buildNotTodoList(snapshot, context);
              },
            );
          },
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return _buildAddTaskButton(context, ref);
      }),
    );
  }

  Widget _buildNotTodoList(
    AsyncSnapshot<List<Task>> snapshot,
    BuildContext context,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('「やるべきでない事」を追加しましょう！'),
            Text(
              'これを明確にすることで、\nあなたは自由な時間を手に入れることができます。',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return ListView(
        children: snapshot.data!
            .map(
              (task) => _buildTaskCard(context, task),
            )
            .toList(),
      );
    }
  }

  Widget _buildAddTaskButton(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.surface,
      onPressed: () {
        clearControllers();

        showGeneralDialog(
          context: context,
          transitionDuration: const Duration(milliseconds: 300),
          barrierDismissible: false,
          barrierLabel: '',
          pageBuilder: (context, animation, secondaryAnimation) {
            return const TaskDialog();
          },
        );
      },
      child: const Center(
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer(builder: (context, ref, child) {
        final taskCardModel = ref.watch(taskCardModelProvider(task));

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('作成日 : ' + Formatter.dateFormat(task.createdAt)),
            SizedBox(height: 4.h),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              tileColor: Colors.grey.shade200,
              onTap: () {
                titleController.text = task.title;
                purposeController.text = task.purpose;
                detailController.text = task.detail ?? '';

                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(milliseconds: 300),
                  barrierDismissible: false,
                  barrierLabel: '',
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return TaskDialog(task: task);
                  },
                );
              },
              title: Text(task.title),
              subtitle: Text(
                task.purpose,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('破った回数'),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.exposure_minus_1),
                      ),
                      Text(
                        task.breakCount.toString(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: taskCardModel.countColor,
                            ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.plus_one),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
