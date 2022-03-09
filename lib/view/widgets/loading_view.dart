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
    return ref.watch(loadingStateProvider)
        ? Container(
            height: 130.h,
            width: 200.w,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Column(
                children: const [
                  CircularProgressIndicator.adaptive(),
                  Text('now loading...'),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
