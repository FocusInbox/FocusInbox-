// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cx_user_email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CxUserEmail _$CxUserEmailFromJson(Map<String, dynamic> json) => CxUserEmail(
      email: json['email'] as String?,
    )..token = json['token'] as String?;

Map<String, dynamic> _$CxUserEmailToJson(CxUserEmail instance) =>
    <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
    };
