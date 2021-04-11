import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

enum _EnumKeys{
  access_token,
  refresh_token
}


class DefaultUtils{

  DefaultUtils._();
  static final DefaultUtils shared = DefaultUtils._();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _getKey(_EnumKeys enumValue){
    switch(enumValue){
      case _EnumKeys.access_token: return "access_token";
      case _EnumKeys.refresh_token: return "refresh_token";
    }
  }

  Future<String> get accessToken async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.access_token);
    return prefs.get(key);
  }


  Future<void> saveAccessToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.access_token);
    prefs.setString(key, token);
  }

  //refresh token

  Future<String> get refreshToken async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.refresh_token);
    return prefs.get(key);
  }

  Future<void> saveRefreshToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    final key = _getKey(_EnumKeys.refresh_token);
    prefs.setString(key, token);
  }

  Future<bool> get autorizUser async {
    final value = await accessToken;
    return value != null;
  }


  ///DELETE ALL
  
  Future<void> deleteAll() async {
    final SharedPreferences prefs = await _prefs;
    
    for (var value in _EnumKeys.values) {
      String key = _getKey(value);
      prefs.remove(key);
    }
  }


}
