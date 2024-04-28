import 'package:json_annotation/json_annotation.dart';
part 'cx_user_phone.g.dart';
@JsonSerializable()

class CxUserPhone {
  String phone ;
  CxUserPhone({required this.phone});

  Map<String,dynamic> toJson() => _$CxUserPhoneToJson(this) ;
}