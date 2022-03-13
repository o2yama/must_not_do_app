import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {
  factory PrefsRepository() => _cache;
  PrefsRepository._internal();
  static final PrefsRepository _cache = PrefsRepository._internal();

  late SharedPreferences _prefs;

  Future<void> getInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int getLaunchStatus() {
    return _prefs.getInt('launchStatus') ?? 0;
  }

  Future<int> incrementLaunchStatus() async {
    final status = getLaunchStatus();

    await _prefs.setInt('launchStatus', status + 1);

    return status + 1;
  }
}
