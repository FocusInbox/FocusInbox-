import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cx_user_registration_model.g.dart';

@JsonSerializable()
class CxUserRegistrationModel {

  String firstName ;
  String lastName ;
  String phone ;
  int platform ;
  String token ;

  @override
  String toString() {
    return 'CxUserRegistrationModel{name: $firstName, phone: $lastName, platform: $platform, token: $token}';
  }

  CxUserRegistrationModel(this.firstName,this.lastName, this.phone,this.platform,this.token);

  toJson() => jsonEncode(_$CxUserRegistrationModelToJson(this));
}