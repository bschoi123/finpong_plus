
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_data.freezed.dart';
part 'client_data.g.dart';

@freezed
class ClientData with _$ClientData{
  factory ClientData({
    required String? apiUserUuid,
    required String? authorities,
    required String? clientId,
    required String? clientSecret,
    required String? clientUuid,
    required String? delYn,
    required int? expiresIn,
    required String? expiryReturnUrl,
    required String? extraInfo,
    required String? identity,
    required String? mydataReturnUrl,
    required String? partner,
    required String? remark,
    required String? returnUrl,
    required String? scope,
    required String? tokenType,
    required String? useEndDate,
    required String? useStartDate,
    required String? useYn ,
  }) = _ClientData;


  factory ClientData.fromJson(Map<String, Object?> json) => _$ClientDataFromJson(json);
}