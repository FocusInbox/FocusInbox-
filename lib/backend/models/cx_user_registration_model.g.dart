// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cx_user_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CxUserRegistrationModel _$CxUserRegistrationModelFromJson(
        Map<String, dynamic> json) =>
    CxUserRegistrationModel(
      json['firstName'] as String,
      json['lastName'] as String,
      json['phone'] as String,
      json['platform'] as int,
      json['token'] as String,
    );

Map<String, dynamic> _$CxUserRegistrationModelToJson(
        CxUserRegistrationModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'platform': instance.platform,
      'token': instance.token,
    };
