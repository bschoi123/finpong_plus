// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finpong_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FinpongResponse _$FinpongResponseFromJson(Map<String, dynamic> json) {
  return _FinpongResponse.fromJson(json);
}

/// @nodoc
mixin _$FinpongResponse {
  Result get result => throw _privateConstructorUsedError;
  ClientData? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinpongResponseCopyWith<FinpongResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinpongResponseCopyWith<$Res> {
  factory $FinpongResponseCopyWith(
          FinpongResponse value, $Res Function(FinpongResponse) then) =
      _$FinpongResponseCopyWithImpl<$Res, FinpongResponse>;
  @useResult
  $Res call({Result result, ClientData? data});

  $ResultCopyWith<$Res> get result;
  $ClientDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$FinpongResponseCopyWithImpl<$Res, $Val extends FinpongResponse>
    implements $FinpongResponseCopyWith<$Res> {
  _$FinpongResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ClientData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResultCopyWith<$Res> get result {
    return $ResultCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ClientDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FinpongResponseCopyWith<$Res>
    implements $FinpongResponseCopyWith<$Res> {
  factory _$$_FinpongResponseCopyWith(
          _$_FinpongResponse value, $Res Function(_$_FinpongResponse) then) =
      __$$_FinpongResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Result result, ClientData? data});

  @override
  $ResultCopyWith<$Res> get result;
  @override
  $ClientDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_FinpongResponseCopyWithImpl<$Res>
    extends _$FinpongResponseCopyWithImpl<$Res, _$_FinpongResponse>
    implements _$$_FinpongResponseCopyWith<$Res> {
  __$$_FinpongResponseCopyWithImpl(
      _$_FinpongResponse _value, $Res Function(_$_FinpongResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = null,
    Object? data = freezed,
  }) {
    return _then(_$_FinpongResponse(
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ClientData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FinpongResponse implements _FinpongResponse {
  _$_FinpongResponse({required this.result, required this.data});

  factory _$_FinpongResponse.fromJson(Map<String, dynamic> json) =>
      _$$_FinpongResponseFromJson(json);

  @override
  final Result result;
  @override
  final ClientData? data;

  @override
  String toString() {
    return 'FinpongResponse(result: $result, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FinpongResponse &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, result, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FinpongResponseCopyWith<_$_FinpongResponse> get copyWith =>
      __$$_FinpongResponseCopyWithImpl<_$_FinpongResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FinpongResponseToJson(
      this,
    );
  }
}

abstract class _FinpongResponse implements FinpongResponse {
  factory _FinpongResponse(
      {required final Result result,
      required final ClientData? data}) = _$_FinpongResponse;

  factory _FinpongResponse.fromJson(Map<String, dynamic> json) =
      _$_FinpongResponse.fromJson;

  @override
  Result get result;
  @override
  ClientData? get data;
  @override
  @JsonKey(ignore: true)
  _$$_FinpongResponseCopyWith<_$_FinpongResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
