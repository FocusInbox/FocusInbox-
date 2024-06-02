import 'dart:async';
import 'dart:convert';

import 'package:http_status_code/http_status_code.dart';

import '../../utils/fi_log.dart';
import '../../utils/fi_resources.dart';
import '../config/fi_backend_config.dart';
import '../models/cx_ai_prompt.dart';
import '../models/cx_ai_prompt_response.dart';
import 'package:http/http.dart' as http;

import '../models/fi_backend_response.dart';

class CxAiApi {
  static final CxAiApi _instance = CxAiApi._internal();

  CxAiApi._internal();

  factory CxAiApi() {
    return _instance;
  }

  Future<CxAiPromptResponse> completion(CxAiPrompt prompt) async {
    CxAiPromptResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};

      var uri = Uri(scheme: backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/ai/completion');
      logger.d("ai completion : $uri");
      FiBackendResponse bResponce = FiBackendResponse.fromHttpResponse(await http.post(uri, body: prompt.toJson(), headers: defaultHeaders).timeout(const Duration(seconds: 10)));
      response = CxAiPromptResponse.fromResponse(bResponce);
    } catch (err) {
      FiBackendResponse bResponce = FiBackendResponse();
      bResponce.status = StatusCode.METHOD_FAILURE;
      bResponce.message = err.toString();
      response = CxAiPromptResponse.fromResponse(bResponce);
    }
    return response;
  }



  Future<bool> chat(CxAiPrompt prompt) async {
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme: backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/ai/chat');
      var request =  http.Request("Post", uri) ;
      request.body = jsonEncode(prompt.toJson()) ;
      request.headers.addAll(defaultHeaders);
      var response = await request.send() ;
      if (response.statusCode != 200) {
        logger.d("AI CHAT RESPONSE: ${response.statusCode}");
        return false ;
      }
      response.stream.listen((value) {
        logger.d(utf8.decode(value));
        prompt.receiver.call(utf8.decode(value)) ;
      },onDone:prompt.onDone,cancelOnError: false) ;


    } catch (err) {
      logger.d("Stream error $err") ;
      return false ;
    }
    return true ;
  }
}

CxAiApi aiApi = CxAiApi();
