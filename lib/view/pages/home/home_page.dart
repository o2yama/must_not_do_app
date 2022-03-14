import 'package:app_review/app_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/utils/formatter.dart';
import 'package:no_todo_app/view/common/ad_widget.dart';
import 'package:no_todo_app/view/dialog/break_count_dialog.dart';
import 'package:no_todo_app/view/dialog/task_dialog.dart';
import 'package:no_todo_app/view_model/break_count_model.dart';
import 'package:no_todo_app/view_model/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<Widget> route() {
    return MaterialPageRoute<Widget>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    /// 初回起動時のみ
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      /// トラッキングの許可リクエスト
      await HomeModel().requestTrackingPermission();

      /// 起動回数取得
      final launchStatus = await HomeModel().incrementLaunchStatus();
      print(launchStatus);

      /// 起動回数が5回の時にレビューのダイアログ表示
      if (launchStatus == 5) await AppReview.requestReview;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 60,
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              fit: BoxFit.contain,
            ),
            Text(
              'しないことリスト',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
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
      floatingActionButton: _buildAddTaskButton(context),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              '「+」ボタンから\n「しないこと」を\n追加しましょう！',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 24.sp),
            ),
          ),
        ],
      );
    } else {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children:
            snapshot.data!.map((task) => _buildTaskCard(context, task)).toList()
              ..add(
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: const BannerAdWidget(),
                ),
              ),
      );
    }
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        HomeModel().getLaunchStatus() == 0
            ? const Icon(
                CupertinoIcons.hand_point_right_fill,
                color: Colors.orangeAccent,
              )
            : const SizedBox(),
        SizedBox(width: 8.w),
        FloatingActionButton(
          backgroundColor: Colors.redAccent,
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
            child: Icon(Icons.add, size: 30),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer(
        builder: (context, ref, child) {
          final breakCountModel = ref.watch(breakCountModelProvider(task));

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('作成日 : ' + Formatter.dateFormat(task.createdAt)),
              SizedBox(height: 4.h),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                tileColor: Colors.grey.shade200,
                onTap: () {
                  titleController.text = task.title;
                  purposeController.text = task.purpose;
                  detailController.text = task.detail ?? '';

                  showGeneralDialog(
                    context: context,
                    transitionDuration: const Duration(milliseconds: 300),
                    barrierDismissible: false,
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return TaskDialog(task: task);
                    },
                  );
                },
                title: Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '目的 : ' + task.purpose,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    ref.watch(breakCountModelProvider(task)).setCountColor();

                    showGeneralDialog(
                      context: context,
                      transitionDuration: const Duration(milliseconds: 300),
                      barrierDismissible: false,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return BreakCountDialog(task: task);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        '破った回数',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        task.breakCount.toString(),
                        style: TextStyle(
                          color: breakCountModel.countColor,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
