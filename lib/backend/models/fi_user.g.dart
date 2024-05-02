// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fi_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CxUser _$CxUserFromJson(Map<String, dynamic> json) => CxUser()
  ..id = json['id'] as String?
  ..username = json['username'] as String?
  ..phonenumber = json['phonenumber'] as String?
  ..organization = json['organization'] as Map<String, dynamic>?
  ..emails = json['emails'] as List<dynamic>
  ..calendars = json['calendars'] as List<dynamic>
  ..groups = json['groups'] as List<dynamic>
  ..information = json['information']
  ..settings = json['settings'] as Map<String, dynamic>?;

Map<String, dynamic> _$CxUserToJson(CxUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phonenumber': instance.phonenumber,
      'organization': instance.organization,
      'emails': instance.emails,
      'calendars': instance.calendars,
      'groups': instance.groups,
      'information': instance.information,
      'settings': instance.settings,
    };
