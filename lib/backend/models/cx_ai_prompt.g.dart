// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cx_ai_prompt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CxAiPrompt _$CxAiPromptFromJson(Map<String, dynamic> json) => CxAiPrompt(
      json['prompt'] as String,
      nPredict: json['n_predict'] as int? ?? 128,
    );

Map<String, dynamic> _$CxAiPromptToJson(CxAiPrompt instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'n_predict': instance.nPredict,
    };
