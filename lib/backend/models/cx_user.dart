import 'package:json_annotation/json_annotation.dart';
part 'cx_user.g.dart';

@JsonSerializable()

class CxUser {
  String? id ;
  String?  username  ;
  String? phonenumber ;
  Map<String,dynamic>? organization ;
  List<dynamic> emails = <String>[];
  List<dynamic> calendars = <String>[];
  List<dynamic> groups = <String>[];
  dynamic information ;
  Map<String,dynamic>? settings ;


  static CxUser fromJson(Map<String,dynamic> json) =>_$CxUserFromJson(json) ;

  bool get hasOrganization => organization?.isNotEmpty??false ;


}