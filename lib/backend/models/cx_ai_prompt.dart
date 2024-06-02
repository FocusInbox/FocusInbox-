import '../../utils/fi_log.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cx_ai_prompt.g.dart';

@JsonSerializable()
class CxAiPrompt {
  String prompt ;
  @JsonKey(name:'n_predict')
  int nPredict ;

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  ValueChanged<String>?  onDataReceiver ;
  ValueChanged<String> get receiver =>(data) {

    onDataReceiver?.call(data);
  };
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  VoidCallback? onDoneReceiver ;
  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  VoidCallback? onErrorReceiver
  ;
  CxAiPrompt(this.prompt,{this.nPredict = 128}) ;

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  VoidCallback get onError => (){
    logger.d("Stream receiver error") ;
    onErrorReceiver?.call() ;
  };

  @JsonKey(includeFromJson: false)
  @JsonKey(includeToJson: false)
  VoidCallback get onDone => (){
    logger.d("Stream receiver done") ;
    onDoneReceiver?.call() ;
  };


  toJson() => _$CxAiPromptToJson(this) ;


}