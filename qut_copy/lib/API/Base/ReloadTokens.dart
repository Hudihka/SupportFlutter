import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';
import 'package:qut/Support/LogOuth/LogOuthUser.dart';


class ReloadTokens {

  DefaultUtils _du = DefaultUtils.shared;

  final dio = Dio();

  Function() fortunately;

  Future load() async {

    String refreshToken = await _du.refreshToken;
    
    if (refreshToken == null){
      print('нет токена, делаем логаут');
      LogOuthUser.logOuth();
    }


    final url = 'https://kc.itmegastar.com/auth/realms/qut/protocol/openid-connect/token';
    Map<String, String> heders = {'Content-Type': 'application/x-www-form-urlencoded'};

    final parametrs = {'client_id': 'public-frontend', 
                       'grant_type': 'refresh_token',
                       'refresh_token': refreshToken,
                       'scope': 'openid profile email'};

    final response = await Dio().post(url, data: parametrs, options: Options(headers: heders));

    if (response.statusCode == 200){
      String content = response.data;
      final obj = json.decode(content);

      await _du.saveAccessToken(obj['access_token']);
      await _du.saveRefreshToken(obj['refresh_token']);

      fortunately();
    } else {
      print('не удалось обновить токены, делаем логаут');
      LogOuthUser.logOuth();
    }
  }


}