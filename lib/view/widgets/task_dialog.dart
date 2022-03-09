import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/db/db.dart';
import 'package:no_todo_app/view_model/task_model.dart';

final titleController = TextEditingController();
final detailController = TextEditingController();

final alertMsgProvider = StateProvider<String?>((ref) => null);

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
            padding: EdgeInsets.only(top: 100.h),
            child: Material(
              color: Colors.black.withOpacity(0),
              child: Container(
                height: 450.h,
                width: 300.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  children: [
                    _buildHeader(context),
                    _alertMsg(context, ref),
                    SizedBox(height: 16.h),
                    _buildTitleField,
                    SizedBox(height: 16.h),
                    _buildDetailField,
                    const Expanded(child: SizedBox()),
                    _buildSaveButtons(context, ref),
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

  Widget _alertMsg(BuildContext context, WidgetRef ref) {
    final msgState = ref.watch(alertMsgProvider);

    return msgState == null
        ? const SizedBox()
        : Text(
            msgState,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.red.shade300, fontSize: 18),
          );
  }

  Widget get _buildTitleField {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: titleController,
        decoration: InputDecoration(
          label: const Text('タスク名'),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'タスク名前を入力してください',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget get _buildDetailField {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: detailController,
        maxLines: 8,
        minLines: 5,
        decoration: InputDecoration(
          label: const Text('詳細'),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'どのようなタスクか、\n明確に定義しておきましょう',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButtons(BuildContext context, WidgetRef ref) {
    final model = ref.watch(taskModelProvider.notifier);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 130.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (ref.watch(alertMsgProvider) == null) {
                    task == null
                        ? await model.storeTask(
                            titleController.text,
                            detailController.text,
                            true,
                          )
                        : await model.updateTask(
                            task!.copyWith(
                              title: titleController.text,
                              detail: detailController.text,
                              isTodo: true,
                            ),
                          );

                    Navigator.pop(context);

                    titleController.clear();
                    detailController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                child: Text(
                  'TODO',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                ),
              ),
            ),
            SizedBox(
              width: 130.w,
              child: ElevatedButton(
                onPressed: () async {
                  model.validateField(
                    titleController.text,
                    detailController.text,
                  );

                  if (ref.watch(alertMsgProvider) == null) {
                    task == null
                        ? await model.storeTask(
                            titleController.text,
                            detailController.text,
                            false,
                          )
                        : await model.updateTask(
                            task!.copyWith(
                              title: titleController.text,
                              detail: detailController.text,
                              isTodo: false,
                            ),
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
                child: FittedBox(
                  child: Text(
                    'Not TODO',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
