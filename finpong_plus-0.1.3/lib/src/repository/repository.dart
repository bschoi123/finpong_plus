//part of finpong_plus;

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/action_code.dart';
import '../constants/conf.dart';
import '../constants/endpoint.dart';
import '../model/finpong_response.dart';
import '../model/result_state.dart';
import '../network/dio_helper.dart';

class Repository {
  Future<ResultState<FinpongResponse>> getLisenceData(String entry) async {
    try {
      final response = await DioHelper.dio.get(licenseUrl,
          queryParameters: {'entry': entry, 'libVersion': libVersion});
      var finpongResponse =
          FinpongResponse.fromJson(jsonDecode(response.toString()));
      if (finpongResponse.result.code != ActionCode.resultSucceed) {
        return ResultState.error(
            finpongResponse.result.code,
            finpongResponse.result.message,
            finpongResponse.result.extraMessage);
      } else {
        return ResultState.success(finpongResponse);
      }
    } on DioError catch (e) {
      String code = '';
      String msg = '네트워크 상태가 좋지않습니다';
      final response = e.response;
      if (response != null) {
        code = response.statusCode!.toString();
        msg = response.statusMessage!;
      }
      return ResultState.error(code, msg, '');
    }
  }

  Future<void> checkLogSend(String clientUuid, String userUuid, String entry,
      String step, String remark) async {
    try {
      var params = {
        "clientUuid": clientUuid,
        "apiUserUuid": userUuid,
        "libVersion": libVersion,
        "entry": entry,
        "step": step,
        "remark": remark,
      };

      await DioHelper.dio.post(checkLogUrl,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }),
          data: params);
    } on DioError catch (e) {
      e.stackTrace;
    }
  }
}
