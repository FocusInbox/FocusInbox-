import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';
import '../../utils/fi_log.dart';
import '../config/cx_backend_config.dart';
import '../models/cx_backend_response.dart';
import '../models/cx_user_registration_model.dart';
import '../models/fi_user_verification_model.dart';

class CxAuthentication {

  static final CxAuthentication _instance = CxAuthentication._internal();

  CxAuthentication._internal();

  factory CxAuthentication() {
    return _instance;
  }

  ///
  /// Start user registration
  Future<CxBackendResponse> registerUser(CxUserRegistrationModel model) async {
    CxBackendResponse? response;
    try {
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json'};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/registration');
      logger.d("registerUser : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri, body: model.toJson(), headers: defaultHeaders).timeout(const Duration(seconds: 10)));
    } catch (err) {
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
    }
    return response;
  }

  Future<CxBackendResponse> verificationUser(CxUserVerificationModel model) async {
    CxBackendResponse? response;
    try {
      Map<String, String> defaultHeaders = {"Content-Type": "application/json", 'accept': 'application/json'};
      var uri = Uri(scheme:backendConfig.scheme, host: backendConfig.host, port: backendConfig.port, path: '/user/verification');
      logger.d("registerUser : $uri");
      response = CxBackendResponse.fromHttpResponse(await http.post(uri, body: model.toJson(), headers: defaultHeaders).timeout(const Duration(seconds: 10)));
    } catch (err) {
      response = CxBackendResponse();
      response.status = StatusCode.METHOD_FAILURE;
      response.message = err.toString();
    }
    return response;
  }

}

CxAuthentication authenticationApi = CxAuthentication() ;