import 'dart:ui';
import 'package:app_settings/app_settings.dart';

import '../../ui/base/fi_base_widget.dart';
import '../../ui/launching/fi_launching_model.dart';
import '../../ui/launching/fi_launching_widget.dart';

import '../../ui/navigationbar/contacts/fi_contacts.dart';
import '../../ui/registration/fi_grant_permission_widget.dart';
import '../../ui/registration/fi_registration_widget.dart';
import '../../ui/registration/fi_verification_widget.dart';
import '../../ui/registration/fi_user_failed_login_widget.dart';
import 'base/fi_model.dart';
import 'fi_main_models_states.dart';
import '../../ui/registration/fi_user_success_login_widget.dart';



class FiMainModel extends FiModel {
  static final FiMainModel _instance = FiMainModel._internal();
  final Map<FiApplicationStates, FiBaseWidget> _pages = {};
  bool _checkingPermissionState = false;


  FiApplicationStates _currentState = FiApplicationStates.launchingState;


  FiContact? currentContact;

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

  FiMainModel._internal() {
    _pages[FiApplicationStates.launchingState] = const FiLaunchingWidgetNew();
    _pages[FiApplicationStates.grantPermissionState] = const FiGrantPermissionWidget();
    _pages[FiApplicationStates.registrationState] = const FiRegistrationWidget();
    _pages[FiApplicationStates.verificationState] = const FiVerificationWidget();
    _pages[FiApplicationStates.userSuccessLoginState] = const FiUserSuccessLoginWidget();
    _pages[FiApplicationStates.userFailedLoginState] = const FiUserFailedLoginWidget();
  }
  factory FiMainModel() {
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

FiMainModel applicationModel = FiMainModel();

