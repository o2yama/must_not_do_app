import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view/common/confoirm_dialog.dart';
import 'package:no_todo_app/view/common/loading_view.dart';
import 'package:no_todo_app/view_model/task_model.dart';

final titleController = TextEditingController();
final purposeController = TextEditingController();
final detailController = TextEditingController();

void clearControllers() {
  titleController.clear();
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
                  width: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                    children: [
                      _buildHeader(context),
                      SizedBox(
                        height: 400.h,
                        child: ListView(
                          children: [
                            _buildTitleField(context),
                            SizedBox(height: 24.h),
                            _buildPurposeField(context),
                            SizedBox(height: 36.h),
                            _buildDetailField,
                            SizedBox(height: 200.h),
                          ],
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 40.w),
            Text(
              task == null ? '「しないこと」追加' : '「しないこと」編集',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 40.w,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '※必須',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red.shade300,
                  fontSize: 12,
                ),
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: const Text('タスク名'),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              suffixText: 'をしない',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurposeField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '※必須',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.red.shade300,
                  fontSize: 12,
                ),
          ),
          TextField(
            controller: purposeController,
            decoration: InputDecoration(
              label: const Text('目的'),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: 'それをしないメリットは？',
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '何かに置き換えると継続しやすくなります。',
            style: TextStyle(fontSize: 11.sp),
          ),
          TextField(
            controller: detailController,
            decoration: InputDecoration(
              label: const Text('代わりのタスク'),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: '例) お菓子を食べる代わりに、ガムを噛む',
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, WidgetRef ref) {
    final model = ref.watch(taskModelProvider);
    final loadingController = ref.watch(loadingStateProvider.notifier);

    return Column(
      children: [
        SizedBox(
          height: 50.h,
          width: 250.w,
          child: ElevatedButton(
            onPressed: () async {
              if (model.validateFields()) {
                loadingController.startLoading();

                task == null
                    ? await model.storeTask(
                        titleController.text,
                        purposeController.text,
                        detailController.text,
                      )
                    : await model.updateTask(
                        task!,
                        titleController.text,
                        purposeController.text,
                        detailController.text,
                      );

                loadingController.endLoading();

                Navigator.pop(context);

                titleController.clear();
                detailController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const StadiumBorder(
                side: BorderSide(color: Colors.redAccent),
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
                  style: TextStyle(color: Colors.grey),
                ),
              ),
      ],
    );
  }
}
