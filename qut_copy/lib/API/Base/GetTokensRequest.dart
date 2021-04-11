
import 'dart:convert';

import 'package:qut/Support/LogOuth/DefaultUtils.dart';
import 'package:dio/dio.dart';
import 'package:qut/API/Base/QUTError.dart';


class GetTokensRequest {

  DefaultUtils _du = DefaultUtils.shared;

  String username;
  String password;

    final dio = Dio();

  GetTokensRequest(this.username, this.password);

  Map<String, String> get _parametrs {
    return {'client_id': 'public-frontend', 
            'grant_type': 'password',
            // 'username': "yyyyyy",
            'username': username,
            'password': password,
            'scope': 'openid profile email'};
  }

  Map<String, String> get _heders{
    return {'Content-Type': 'application/x-www-form-urlencoded'};
  }

  Function({QUTError error}) endRequest;

  Future load() async {

    dynamic url = 'https://kc.itmegastar.com/auth/realms/qut/protocol/openid-connect/token';

    // final uri = Uri.parse(url);

    final response = await Dio().post(url, data: _parametrs, options: Options(headers: _heders));

    final statusCode = response.statusCode;

    if (statusCode == 200){
      String content = response.data;

      final obj = json.decode(content);

      await _du.saveAccessToken(obj['access_token']);
      await _du.saveRefreshToken(obj['refresh_token']);

      endRequest();
    } else {
      String jsonsDataString = response.data.toString();
      _errorHandler(jsonsDataString, statusCode);
    }
  }

  _errorHandler(String content, int statusCode){

    QUTError error;

    if (content.contains('{')){
      final decoJson = json.decode(content);
      error = QUTError.fromJson(decoJson);
    } else {
      error = QUTError(errorDescription: content);
    }

    if (statusCode > 399){
      String errorText = error.errorDescription;
      error.errorDescription = "Ошибка 400  " + errorText;
    }


    endRequest(error: error);

  }


}