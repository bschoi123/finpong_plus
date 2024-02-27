import 'package:finpong_plus/src/model/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'client_data.dart';

part 'finpong_response.freezed.dart';
part 'finpong_response.g.dart';

@freezed
class FinpongResponse with _$FinpongResponse {
  factory FinpongResponse(
      {required Result result,
      required ClientData? data}) = _FinpongResponse;

  factory FinpongResponse.fromJson(Map<String, dynamic> json) => _$FinpongResponseFromJson(json);
}
