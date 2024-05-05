import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'fi_user_verification_model.g.dart';

@JsonSerializable()
class FiUserVerificationModel {
 // String? verification ;
  String? mail ;

  String toJson()=> jsonEncode(_$FiUserVerificationModelToJson(this));
}