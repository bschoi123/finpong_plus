// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_ClientData _$$_ClientDataFromJson(Map<String, dynamic> json) =>
    _$_ClientData(
      apiUserUuid: json['apiUserUuid'] as String?,
      authorities: json['authorities'] as String?,
      clientId: json['clientId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      clientUuid: json['clientUuid'] as String?,
      delYn: json['delYn'] as String?,
      expiresIn: json['expiresIn'] as int?,
      expiryReturnUrl: json['expiryReturnUrl'] as String?,
      extraInfo: json['extraInfo'] as String?,
      identity: json['identity'] as String?,
      mydataReturnUrl: json['mydataReturnUrl'] as String?,
      partner: json['partner'] as String?,
      remark: json['remark'] as String?,
      returnUrl: json['returnUrl'] as String?,
      scope: json['scope'] as String?,
      tokenType: json['tokenType'] as String?,
      useEndDate: json['useEndDate'] as String?,
      useStartDate: json['useStartDate'] as String?,
      useYn: json['useYn'] as String?,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_ClientDataToJson(_$_ClientData instance) =>
    <String, dynamic>{
      'apiUserUuid': instance.apiUserUuid,
      'authorities': instance.authorities,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'clientUuid': instance.clientUuid,
      'delYn': instance.delYn,
      'expiresIn': instance.expiresIn,
      'expiryReturnUrl': instance.expiryReturnUrl,
      'extraInfo': instance.extraInfo,
      'identity': instance.identity,
      'mydataReturnUrl': instance.mydataReturnUrl,
      'partner': instance.partner,
      'remark': instance.remark,
      'returnUrl': instance.returnUrl,
      'scope': instance.scope,
      'tokenType': instance.tokenType,
      'useEndDate': instance.useEndDate,
      'useStartDate': instance.useStartDate,
      'useYn': instance.useYn,
    };
