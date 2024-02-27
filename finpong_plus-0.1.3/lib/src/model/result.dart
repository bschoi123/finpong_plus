import 'package:freezed_annotation/freezed_annotation.dart';
part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class Result with _$Result {
  factory Result({
    required String code,
    required String extraMessage,
    required String message,
    required String txId,
    required String timestamp,
  }) = _Result;

  factory Result.fromJson(Map<String, Object> json) => _$ResultFromJson(json);
}
