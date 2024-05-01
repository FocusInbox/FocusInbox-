import 'dart:ui';
import 'package:app_settings/app_settings.dart';

import '../../ui/base/fi_base_widget.dart';
import '../../ui/launching/fi_launching_model.dart';
import '../../ui/launching/fi_launching_widget.dart';

import '../../ui/navigationbar/contacts/fi_contacts.dart';
import '../../ui/registration/cx_grant_permission_widget.dart';
import '../../ui/registration/cx_registration_widget.dart';
import '../../ui/registration/cx_verification_widget.dart';
import '../../ui/registration/fi_user_failed_login.dart';
import 'base/fi_model.dart';
import 'fi_main_models_states.dart';
import '../../ui/registration/cx_user_success_login_widget.dart';



class CxMainModel extends FiModel {
  static final CxMainModel _instance = CxMainModel._internal();
  final Map<FiApplicationStates, FiBaseWidget> _pages = {};
  bool _checkingPermissionState = false;


  FiApplicationStates _currentState = FiApplicationStates.registrationState;


  CxContact? currentContact;

  set currentState(FiApplicationStates value) {
    update(callback: () {
      _currentState = value;
    });
  }

  setCurrentStateWithParams(FiApplicationStates value, dynamic params) {
    _pages[value]?.setParams(params);
    update(callback: () {
      _currentState = value;
    });
  }

  CxMainModel._internal() {
    _pages[FiApplicationStates.launchingState] = const CxLaunchingWidgetNew();
    _pages[FiApplicationStates.grantPermissionState] = const CxGrantPermissionWidget();
    _pages[FiApplicationStates.registrationState] = const CxRegistrationWidget();
    _pages[FiApplicationStates.verificationState] = const CxVerificationWidget();
    _pages[FiApplicationStates.userSuccessLoginState] = const CxUserSuccessLoginWidget();
    _pages[FiApplicationStates.userFailedLoginState] = const FiUserFailedLoginWidget();
  }
  factory CxMainModel() {
    return _instance;
  }

 // FiBaseWidget get currentPage => _pages[_currentState]!;//TODO:RETURN IT
  FiBaseWidget get currentPage {
    var page = _pages[_currentState];
    if (page == null) {
      print("Warning: No page found for state $_currentState");
      return _pages[_currentState]!;  // Return a default page or handle as needed
    }
    return page;
  }


  Future<void> openPermissionsSettings() async {
    AppSettings.openAppSettings(type: AppSettingsType.settings);
    _checkingPermissionState = true;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        if (_checkingPermissionState) {
          _checkingPermissionState = false;
          launchingModel.reCheckPermissions();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  void logout() {}
}

CxMainModel applicationModel = CxMainModel();

