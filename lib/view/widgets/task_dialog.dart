import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.h, bottom: 20.h),
            child: Material(
              color: Colors.black.withOpacity(0),
              child: Container(
                width: 300.w,
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
              task == null ? 'タスク追加' : 'タスク編集',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 18.sp,
                  ),
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
              hintText: 'やめるタスクを入力',
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
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              label: const Text('目的'),
              filled: true,
              fillColor: Colors.grey.shade200,
              hintText: 'それをやめた時のメリットは？',
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
      child: TextField(
        controller: detailController,
        minLines: 3,
        maxLines: 5,
        decoration: InputDecoration(
          label: const Text('詳細'),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'どのようなことをしないのか、\n具体的に決めておきましょう',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context, WidgetRef ref) {
    final model = ref.watch(taskModelProvider.notifier);

    return Column(
      children: [
        SizedBox(
          width: 250.w,
          child: ElevatedButton(
            onPressed: () async {
              if (model.validateFields()) {
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
              task == null ? 'これはやらない！' : '保存',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
