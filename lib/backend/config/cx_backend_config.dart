class CxBackendConfig {
  static final CxBackendConfig _instance = CxBackendConfig._internal();

  CxBackendConfig._internal();

  factory CxBackendConfig() {
    return _instance;
  }

  final stage = "82.81.45.49" ;

  final dev = "84.228.159.31" ;

  String get host {
    return dev ;
  }

  final port = 7882 ;

  final scheme = "http" ;

  final Duration timeout = const Duration(seconds: 20) ;

}

CxBackendConfig backendConfig = CxBackendConfig();