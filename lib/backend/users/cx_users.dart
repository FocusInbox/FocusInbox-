import 'dart:convert';
import 'package:http_status_code/http_status_code.dart';
import '../../utils/fi_log.dart';
import '../../utils/fi_resources.dart';
import '../config/cx_backend_config.dart';
import '../models/cx_backend_response.dart';
import '../models/cx_user.dart';
import 'package:http/http.dart' as http;
import '../models/cx_user_email.dart';
import '../models/cx_user_phone.dart';
import '../models/fi_user_notification_settings.dart';

class CxUsers {
  static final CxUsers _instance = CxUsers._internal();

  CxUsers._internal();

  factory CxUsers() {
    return _instance;
  }

  Future<CxUser?> loadUser(String token) async{
    CxBackendResponse? response;
    try {
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/information');
      logger.d("loadUser url : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.get(uri, headers: defaultHeaders).timeout(backendConfig.timeout));
      if(response.successful()){
        CxUser user = CxUser.fromJson(response.data!) ;
        return user ;
      }
    } catch (err) {
      logger.d("loadUser error : $err");
    }
    return null ;
  }

  Future<CxBackendResponse> addEmail(CxUserEmail userEmail) async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/email/add');
      logger.d("addEmail : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri,body: userEmail.toJson(), headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addEmail : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }


  Future<CxBackendResponse> updateSettings(CxUserNotificationSettings settings) async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/settings/notification');
      logger.d("updateSettings : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri,body: settings.toJson(), headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("updateSettings : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }

/*  Future<CxBackendResponse> listEmails() async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/email/list');
      logger.d("addEmail : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri, headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addEmail : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }*/

  Future<CxBackendResponse> addCalendar(CxUserEmail userEmail) async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/calendar/add');
      logger.d("addCalendar : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri,body: userEmail.toJson(), headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addCalendar : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }

/*  Future<CxBackendResponse> listCalendars() async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/calendar/list');
      logger.d("addEmail : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri, headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addEmail : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }*/

/*  Future<CxBackendResponse> convert(CxGroupUserModel model) async {
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/convert/register');
      logger.d("convert : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri,body: jsonEncode(model.toJson), headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addCalendar : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }*/

  Future<CxBackendResponse> addPhone(CxUserPhone userPhone)async{
    CxBackendResponse? response;
    try {
      String token = resources.storage.getString(kAccessNotificationToken);
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json',"Token":token};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/settings/add/phone');
      logger.d("addPhone : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri,body:jsonEncode(userPhone.toJson()) , headers: defaultHeaders).timeout(backendConfig.timeout));
      return response ;
    } catch (err) {
      logger.d("addPhone : $err");
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
      return response ;
    }
  }
}

CxUsers usersApi = CxUsers();