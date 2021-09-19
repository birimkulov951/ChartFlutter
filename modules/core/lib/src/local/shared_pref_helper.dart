import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  final SharedPreferences preferences;
  SharedPrefHelper({@required this.preferences});

  static const LAST_CHECKED = "last_checked";
  static const CHECK_INTERVAL = "check_interval";
  static const DATA = "data";
  static const THEME = "theme";


  Future saveValueDarkTheme(bool value) async {
    await preferences.setBool(THEME, value);
  }

  Future<bool> getValueDarkTheme() async {
    return preferences.getBool(THEME) ?? false;
  }

  /// Interval 30000 means handle cache for 30000 milliseconds or 0.5 minute
  Future<bool> storeCache(String key, String json,
      {int lastChecked, int interval = 1000}) {

    lastChecked ??= DateTime.now().millisecondsSinceEpoch;

    return preferences.setString(
        key,
        jsonEncode({
          LAST_CHECKED: lastChecked,
          CHECK_INTERVAL: interval,
          DATA: json
        }));
  }

  Future<String> getCache(String key) async {

    Map map = jsonDecode(preferences.getString(key));

    /// if outdated, clear and return null
    var lastChecked = map[LAST_CHECKED];
    var interval = map[CHECK_INTERVAL];

    if ((DateTime.now().millisecondsSinceEpoch - lastChecked) > interval) {

      await preferences.remove(key);
      return null;

    }
    return map[DATA];
  }

}
