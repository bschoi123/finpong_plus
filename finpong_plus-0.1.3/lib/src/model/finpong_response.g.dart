// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finpong_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
// ignore: non_constant_identifier_names
_$_FinpongResponse _$$_FinpongResponseFromJson(Map<String, dynamic> json) =>
    _$_FinpongResponse(
      result: Result.fromJson((json['result'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, e as Object),
      )),
      data: json['data'] == null
          ? null
          : ClientData.fromJson(json['data'] as Map<String, dynamic>),
    );
// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_FinpongResponseToJson(_$_FinpongResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'data': instance.data,
    };
