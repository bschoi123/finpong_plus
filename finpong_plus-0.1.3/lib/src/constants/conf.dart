//part of finpong_plus;

import 'package:finpong_plus/src/constants/server_mode.dart';

import 'endpoint.dart';

const String libVersion = '0.1.3';
var serverMode = ServerMode.staging;
const aosHandleName = "webkitAndroid";
const iosHandleName = "FP_Handler";

String getBaseUrl() {
  String result = baseUrlDev;

  switch (serverMode) {
    case ServerMode.dev:
      result = baseUrlDev;
      break;
    case ServerMode.release:
      result = baseUrlRelease;
      break;
    case ServerMode.staging:
      result = baseUrlTest;
      break;
  }
  return result;
}