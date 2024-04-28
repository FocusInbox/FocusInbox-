import 'dart:convert';

import 'package:googleapis/cloudsearch/v1.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cx_user_registration_model.g.dart';

@JsonSerializable()
class CxUserRegistrationModel {

  String firstName ;
  String lastName ;
  String mail ;
  int platform ;
  String token ;

  @override
  String toString() {
    return 'CxUserRegistrationModel{name: $firstName, mail: $mail, platform: $platform, token: $token}';
  }

  CxUserRegistrationModel(this.firstName,this.lastName, this.mail,this.platform,this.token);

  toJson() => jsonEncode(_$CxUserRegistrationModelToJson(this));
}