import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_state.freezed.dart';

@freezed
abstract class ResultState<T> with _$ResultState<T> {
  //Union
  const factory ResultState.success(T data) = Success;

  const factory ResultState.loading() = Loading;

  const factory ResultState.error(String code, String msg, String extraMsg) =
      Error;
}
// 수정 시 terminal 입력  -> flutter pub run build_runner build
