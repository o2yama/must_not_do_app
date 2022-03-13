import 'package:no_todo_app/repository/prefs_repository.dart';
import 'package:no_todo_app/utils/att.dart';

class HomeModel {
  factory HomeModel() => _cache;
  HomeModel._internal();
  static final HomeModel _cache = HomeModel._internal();

  final _prefs = PrefsRepository();

  Future<void> requestTrackingPermission() async {
    final status = _prefs.getLaunchStatus();

    if (status == 0) await ATT.requestPermission();
  }

  Future<int> incrementLaunchStatus() async {
    final status = await _prefs.incrementLaunchStatus();

    return status;
  }
}
