import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'fi_user_verification_model.g.dart';

@JsonSerializable()
class CxUserVerificationModel {
  String? verification ;
  String? phone ;

  String toJson()=> jsonEncode(_$CxUserVerificationModelToJson(this));
}