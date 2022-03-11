import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final loadingStateProvider = StateNotifierProvider<LoadingState, bool>(
  (ref) => LoadingState(),
);

class LoadingState extends StateNotifier<bool> {
  LoadingState() : super(false);

  void startLoading() => state = true;

  void endLoading() => state = false;
}

class LoadingView extends ConsumerWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.6),
      child: Center(
        child: Container(
          height: 130.h,
          width: 200.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
                SizedBox(height: 16.h),
                const Material(child: Text('now loading...')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
