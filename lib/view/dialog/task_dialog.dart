import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/utils/screen_data.dart';
import 'package:no_todo_app/view/common/confoirm_dialog.dart';
import 'package:no_todo_app/view/common/loading_view.dart';
import 'package:no_todo_app/view_model/task_card_model.dart';

final taskNameController = TextEditingController();
final purposeController = TextEditingController();
final detailController = TextEditingController();

void clearControllers() {
  taskNameController.clear();
  purposeController.clear();
  detailController.clear();
}

class TaskDialog extends ConsumerWidget {
  const TaskDialog({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
              child: Material(
                color: Colors.black.withOpacity(0),
                child: Container(
                  width: ScreenData.isMobile ? 350.w : 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(
                        height: 350.h,
                        child: ListView(
                          children: [
                            _buildTaskNameField(context),
                            SizedBox(height: 24.h),
                            _buildPurposeField(context),
                            SizedBox(height: 36.h),
                            _buildDetailField,
                            SizedBox(height: 200.h),
                          ],
                        ),
                      ),
                      BubbleSpecialThree(
                        text: 'ファイト!!',
                        color: Colors.green.withOpacity(0.7),
                        tail: true,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenData.isMobile ? 16.sp : 12.sp,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      _buildSaveButton(context, ref),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: ref.watch(loadingStateProvider),
            child: const LoadingView(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: SizedBox(
          height: 50.h,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 40.w),
                Text(
                  task == null ? '「しないこと」追加' : '「しないこと」編集',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScreenData.isMobile ? 20.sp : 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.clear,
                      size: ScreenData.isMobile ? 22.sp : 18.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '※必須',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent,
                  fontSize: ScreenData.isMobile ? 12.sp : 8.sp,
                ),
          ),
          TextField(
            controller: taskNameController,
            style: TextStyle(fontSize: ScreenData.isMobile ? 14.sp : 10.sp),
            decoration: InputDecoration(
              label: const Text('しないこと'),
              labelStyle: TextStyle(
                fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurposeField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '※必須',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent,
                  fontSize: ScreenData.isMobile ? 12.sp : 8.sp,
                ),
          ),
          TextField(
            controller: purposeController,
            style: TextStyle(fontSize: ScreenData.isMobile ? 14.sp : 10.sp),
            decoration: InputDecoration(
              label: const Text('目的'),
              labelStyle: TextStyle(
                fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: 'それをしないメリットは？',
              hintStyle: TextStyle(
                fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildDetailField {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '何かに置き換えると継続しやすくなります',
            style: TextStyle(
              fontSize: ScreenData.isMobile ? 12.sp : 8.sp,
            ),
          ),
          TextField(
            controller: detailController,
            style: TextStyle(fontSize: ScreenData.isMobile ? 14.sp : 10.sp),
            decoration: InputDecoration(
              label: const Text('代わりのタスク'),
              labelStyle: TextStyle(
                fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
              ),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: '例) お菓子を食べる代わりにガムを噛む',
              hintStyle: TextStyle(
                fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, WidgetRef ref) {
    final model = ref.watch(taskCardModelProvider);
    final loadingController = ref.watch(loadingStateProvider.notifier);

    return Column(
      children: [
        SizedBox(
          height: ScreenData.isMobile ? 50.h : 40.h,
          width: ScreenData.isMobile ? 250.w : 200.w,
          child: ElevatedButton(
            onPressed: () async {
              if (model.validateFields()) {
                loadingController.startLoading();

                task == null
                    ? await model.storeTask(
                        taskNameController.text,
                        purposeController.text,
                        detailController.text,
                      )
                    : await model.updateTask(
                        task!,
                        taskNameController.text,
                        purposeController.text,
                        detailController.text,
                      );

                loadingController.endLoading();

                Navigator.pop(context);

                taskNameController.clear();
                detailController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.redAccent,
                  width: ScreenData.isMobile ? 1 : 2,
                ),
              ),
            ),
            child: Text(
              task == null ? 'これはしない！' : '保存',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
            ),
          ),
        ),
        task == null
            ? Container()
            : TextButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(task: task!),
                  );
                },
                child: const Text(
                  'タスク削除',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
      ],
    );
  }
}
