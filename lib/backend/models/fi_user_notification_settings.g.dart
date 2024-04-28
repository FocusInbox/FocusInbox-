// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fi_user_notification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


CxUserNotificationSettings _$CxUserNotificationSettingsFromJson(
    Map<String, dynamic> json) =>
    CxUserNotificationSettings(
      allowedFrom: json['allowedfrom'] as int,
      allowedTo: json['allowedto'] as int,
      relatedToMe: json['relatedtome'] as bool,
      any: json['any'] as bool,
    );

Map<String, dynamic> _$CxUserNotificationSettingsToJson(
    CxUserNotificationSettings instance) =>
    <String, dynamic>{
      'allowedfrom': instance.allowedFrom,
      'allowedto': instance.allowedTo,
      'relatedtome': instance.relatedToMe,
      'any': instance.any,
    };
