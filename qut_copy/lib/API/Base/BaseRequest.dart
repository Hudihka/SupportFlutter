import 'dart:convert';

import 'package:app_logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:qut/API/Base/QUTError.dart';
import 'package:qut/API/Base/ReloadTokens.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Support/LogOuth/DefaultUtils.dart';

enum EnumMetods { postReq, getReq }

typedef OnEndRequest({QUTError error});
typedef OnEndRequestJson({dynamic obj, QUTError error});
typedef OnEndRequestListJson({List<dynamic> objs, QUTError error});

class BaseRequest {
  dynamic get _getUrl {
    dynamic baseURL = 'https://qut.itmegastar.com/api/v1/';
    return baseURL + strUrl;
  }

  static Map<String, String> _heders = {
    'Host': 'qut.itmegastar.com',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzdlZFVUg5SlRTYzk2cFMxMnhTZng1d012NEU4T3JFRWdGZmpRb1dkcmlBIn0.eyJleHAiOjE2MjA0NjAzMzAsImlhdCI6MTYxNzg2ODMzMCwianRpIjoiMTIzZGM0MzEtOWM2NC00YTVmLWE3ZDktOGRhZWU3N2JhYmRhIiwiaXNzIjoiaHR0cHM6Ly9rYy5pdG1lZ2FzdGFyLmNvbS9hdXRoL3JlYWxtcy9xdXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMjYxYTllMzAtYjEwZi00YWY4LWExMGQtY2I2MDczYzlkNDU0IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoicHVibGljLWZyb250ZW5kIiwic2Vzc2lvbl9zdGF0ZSI6ImYwOWQ4YzNhLTFjNTItNGY4Ny04NTI3LWM5N2YxMzM1MTJlNiIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6ImVtYWlsIHByb2ZpbGUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXSwibmFtZSI6IkRlbW8gVXNlciBVIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiZGVtbyIsImdpdmVuX25hbWUiOiJEZW1vIiwiZmFtaWx5X25hbWUiOiJVc2VyIFUiLCJlbWFpbCI6ImRlbW9AZGVtby5ydSJ9.gxu770Wi6xbVcHg6zd7cbjjD35LHPaGKc4LD5U5juRLaGgG0oEyMw0wSTeoy2md9LmJJXciZ5AhAqXnjlnExWOA-Ny5vqiFs6lzDZiDVZdZJ2nczFiLYAhwdRnZMuKujV8HePd1zS6DROwoG0l48uzT3MMCiArsT_B9xolm78osMdqZMEEN9UWL_HZ1YDncQk2PhWxxVr4xOsTPngazQ8Jmq264Os-pejkv2Mra61hy6Xdo2XGlgsZ_FDcIbIZBPxCROkoAN1jS7FAY1tsxySVKC6TkfH7x3HpybE6VGRFwDrMvYK2xRrWLw3jQbZbPbQor2EYhkrra7SMeK_Holvw',
  };

  OnEndRequest endRequest;
  OnEndRequestJson endRequestJson;
  OnEndRequestListJson endRequestListJson;

  @override
  String get strUrl {
    return "";
  }

  @override
  handleList({List<Map<String, dynamic>> json, QUTError error}) {}

  @override
  handleOne({Map<String, dynamic> json, QUTError error}) {}

  @override
  handle({QUTError error}) {}

  @override
  Map<String, dynamic> parametrs() {
    return {};
  }

  @override
  EnumMetods metods = EnumMetods.getReq;


  static Dio dio = Dio(BaseOptions(headers: _heders));

  static init() {
    dio.interceptors.add(LoggerInterceptor());
  }

  Future<Response> _getResponse(String url) async {
    String aT = await DefaultUtils.shared.accessToken;

    if (aT != null){
      _heders["Authorization"] = "Bearer " + aT;
    }



    print('$url');
    switch (metods) {

      case EnumMetods.getReq:
        if (parametrs().isEmpty) {
          final req = await dio.get(url);
          // final number = await LoggerHttp().onRequest(url, 'GET', headers: _heders, request: req);
          // final res = await req;
          // LoggerHttp().onResponse(req, number);
          return req;
        }

        final req = await dio.get(url, queryParameters: parametrs());
        // final number = await LoggerHttp().onRequest(requestUrl, 'GET',
        //     headers: _heders, request: req, params: parametrs());
        // final res = await req;
        // LoggerHttp().onResponse(res, number);
        return req;

      case EnumMetods.postReq:

        final req = await dio.post(url, data: parametrs());
        // final number = await LoggerHttp().onRequest(uri3, 'POST',
        //     headers: _heders, request: req, params: parametrs());
        // final res = await req;
        // LoggerHttp().onResponse(res, number);
        return req;
    }
  }

  Future load() async {
    final value = await needToReloadAccessToken();

    //значит нужно обновить токены;
    if (value) {
      _reloadTokens();
      return;
    }

    final response = await _getResponse(_getUrl);

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      var content = response.data;
      _showContent(content);
    } else {
      print('ошибка');

      var jsonsDataString = response.data;

      // dynamic content = jsonDecode(jsonsDataString);
      _errorHandler(jsonsDataString, statusCode);
    }
  }

  _reloadTokens() {
    ReloadTokens reloadTokwnsReq = ReloadTokens();
    reloadTokwnsReq.load();

    reloadTokwnsReq.fortunately = () {
      load();
    };
  }

  _errorHandler(String content, int statusCode) {
    QUTError error;

    if (content.contains('{')) {
      final decoJson = json.decode(content);
      error = QUTError.fromJson(decoJson);
    } else {
      error = QUTError(errorDescription: content);
    }

    if (statusCode > 399) {
      String errorText = error.errorDescription;
      error.errorDescription = "Ошибка 400  " + errorText;
    }

    //добавить проверку на ошибку
    //если пришла что токен протух то _reloadTokens()
    //иначе код ниже

    handleList(error: error);
    handleOne(error: error);
    handle(error: error);
  }

  _showContent( content) {

    if (content is List<Map<String, dynamic>>) {
      handleList(json: content);
    } else if (content is Map<String, dynamic>) {
      handleOne(json: content);
    } else {
      handle();
    }
  }

  //методы по обновлению токена

  Future<bool> needToReloadAccessToken() async {
    String _AT = await DefaultUtils.shared.accessToken;

    if (_AT != null) {
      final map = _AT.parseJwt();
      int exp = map['exp'];

      if (exp != null) {
        final date =
            DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
        DateTime now = DateTime.now();
        final difference = date.difference(now).inSeconds;

        return difference < 120;
      }
    }

    return false;
  }
}
