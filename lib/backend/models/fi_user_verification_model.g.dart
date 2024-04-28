// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fi_user_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CxUserVerificationModel _$CxUserVerificationModelFromJson(
        Map<String, dynamic> json) =>
    CxUserVerificationModel()
      ..verification = json['verification'] as String?
      ..phone = json['phone'] as String?;

Map<String, dynamic> _$CxUserVerificationModelToJson(
        CxUserVerificationModel instance) =>
    <String, dynamic>{
      'verification': instance.verification,
      'phone': instance.phone,
    };
