
class AppEnv {
  static var mapValues = {};

  static var hasConnectLoggerRemote =
      mapValues['hasConnectLoggerRemote'] ?? true;

  static var loggerUrl = mapValues['loggerUrl'] ??
      'ws://ws_logger_server_1332.ovz1.j1121565.m2oon.vps.myjino.ru:80';
  // static var loggerUrl = mapValues['loggerUrl'] ?? 'ws://10.0.2.2:6001';

  static var loggerProject = mapValues['loggerProject'] ?? 'QUT';
}
