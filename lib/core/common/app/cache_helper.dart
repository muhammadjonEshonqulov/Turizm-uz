import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../singletons/cache.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;
  static const _sessionTokenKey = 'user-session-token';
  static const _fullNameKey = 'user-full-name';
  static const _userRollKey = 'user-roll';
  static const _photoKey = 'user-photo';
  static const _userIdKey = 'user-id';

  Future<bool> cacheSessionToken(String token) async {
    try {
      final result = await _prefs.setString(_sessionTokenKey, token);
      Cache.instance.setSessionToken(token);
      return result;
    } catch (_) {
      return false;
    }
  }

  String get fullName => _prefs.getString(_fullNameKey) ?? '--';
  String get userPhoto => _prefs.getString(_photoKey) ?? '--';
  String get userRollKey => _prefs.getString(_userRollKey) ?? '--';

  Future<bool> cacheFullName(String fullName) async {
    try {
      final result = await _prefs.setString(_fullNameKey, fullName);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> cacheRoll(String fullName) async {
    try {
      final result = await _prefs.setString(_userRollKey, fullName);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<bool> cachePhoto(String id) async {
    try {
      final result = await _prefs.setString(_photoKey, id);
      return result;
    } catch (_) {
      return false;
    }
  }

  Future<void> clearAllData() async {
    await _prefs.clear();
  }

  Future<bool> cacheUserId(String userId) async {
    try {
      final result = await _prefs.setString(_userIdKey, userId);
      Cache.instance.setUserId(userId);
      return result;
    } catch (_) {
      return false;
    }
  }



  String? getSessionToken() {
    final sessionToken = _prefs.getString(_sessionTokenKey);
    if (sessionToken != null) {
      debugPrint('getSessionToken: Session Token exists');
      Cache.instance.setSessionToken(sessionToken);
    } else {
      debugPrint('getSessionToken: session does not exist');
    }
    return sessionToken;
  }

  String? getUserId() {
    final userId = _prefs.getString(_userIdKey);
    if (userId != null) {
      debugPrint('getUserId: user exists');
      Cache.instance.setUserId(userId);
    } else {
      debugPrint('getUserId: user does not exist');
    }
    return userId;
  }


  // bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;
}
