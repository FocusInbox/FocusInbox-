import 'package:json_annotation/json_annotation.dart';
part 'fi_user.g.dart';

@JsonSerializable()

class FiUser {
  String? id ;
  String?  username  ;
  String? phonenumber ;
  Map<String,dynamic>? organization ;
  List<dynamic> emails = <String>[];
  List<dynamic> calendars = <String>[];
  List<dynamic> groups = <String>[];
  dynamic information ;
  Map<String,dynamic>? settings ;


  static FiUser fromJson(Map<String,dynamic> json) =>_$FiUserFromJson(json) ;

  bool get hasOrganization => organization?.isNotEmpty??false ;


}