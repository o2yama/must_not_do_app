import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view/widgets/task_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 1),
      body: SafeArea(
        left: false,
        right: false,
        child: Consumer(
          builder: (context, ref, child) {
            final _db = ref.watch(dbProvider);

            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Task>>(
                    stream: _db.watchTodos(),
                    builder: (context, snapshot) {
                      return _buildTodoList(snapshot, context);
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Task>>(
                    stream: _db.watchNotTodos(),
                    builder: (context, snapshot) {
                      return _buildNotTodoList(snapshot, context);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildTodoList(
    AsyncSnapshot<List<Task>> snapshot,
    BuildContext context,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (snapshot.hasData) {
      return ListView(
        children: [
          Container(
            color: Colors.blueAccent,
            height: 30.h,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'TODO',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 270.h,
            child: ListView(
              children: snapshot.data!
                  .map(
                    (task) => _buildTaskCard(context, task),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text('あなたの「やるべき事」を追加しましょう！'),
      );
    }
  }

  Widget _buildNotTodoList(
    AsyncSnapshot<List<Task>> snapshot,
    BuildContext context,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (snapshot.hasData) {
      return ListView(
        children: [
          Container(
            color: Colors.redAccent,
            height: 30.h,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'NOT TODO',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 270.h,
            child: ListView(
              children: snapshot.data!
                  .map(
                    (task) => _buildTaskCard(context, task),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else {
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
    }
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.surface,
      onPressed: () {
        titleController.clear();
        detailController.clear();

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
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        tileColor: Colors.grey.shade200,
        onTap: () {
          titleController.text = task.title;
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
          task.detail ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
