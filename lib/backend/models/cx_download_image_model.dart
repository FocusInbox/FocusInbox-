import 'package:json_annotation/json_annotation.dart';
part 'cx_download_image_model.g.dart';

@JsonSerializable()
class CxDownloadImageModel {
  String id ;
  CxDownloadImageModel(this.id) ;

  Map<String,dynamic> toJson() => _$CxDownloadImageModelToJson(this);
}