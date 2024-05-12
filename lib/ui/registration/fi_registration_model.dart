import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:http_status_code/http_status_code.dart';
import '../../backend/authentication/fi_authentication.dart';
import '../../backend/models/fi_backend_response.dart';
import '../../backend/models/fi_user_registration_model.dart';
import '../../backend/models/fi_user_verification_model.dart';
import '../../backend/users/fi_users.dart';
import '../../models/main/base/fi_model.dart';
import '../../models/main/fi_main_model.dart';
import '../../models/main/fi_main_models_states.dart';
import '../../utils/fi_log.dart';
import '../../utils/fi_resources.dart';
import '../contacts/fi_contacts_tab_widget.dart';
import '../launching/fi_launching_model.dart';
import '../navigationbar/contacts/fi_contacts.dart';

class FiRegistrationModel extends FiModel {
  static final FiRegistrationModel _instance = FiRegistrationModel._internal();
  Timer? _resendCodeTimer;
  int _timoutForEnableResendCode = 5*60;//5 * 60
  bool _isTimerStarted = false ;
  String? _userFirstName ;
  String? _userLastName ;
  String? _userVerificationCode ;
  bool _isResendAllowed = false ;
  String? _mailAddress ;
  bool _verificationInProgress = false ;
  bool _resendCodeInProgress = false ;
  bool _isRegistationInProgress = false ;
  FiUserRegistrationModel? _userRegistrationModel;
  FiRegistrationModel._internal();

  factory FiRegistrationModel() {
    return _instance;
  }



  ValueChanged<String> get onUserFirstNameChange => (username) {
    update(callback:(){
      _userFirstName = username ;
    }) ;
  };

  ValueChanged<String> get onUserLastNameChange => (username) {
    update(callback:(){
      _userLastName = username ;
    }) ;
  };

  ValueChanged<String> get onMailAddressChange => (mailaddress) {
    update(callback:(){
      _mailAddress = mailaddress ;
    }) ;
  };

/*  ValueChanged<String> get onMailAddressChange => (mailaddress) {
    update(callback: () {
      // Regular expression pattern to validate email
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
      RegExp regex = RegExp(pattern);

      if (regex.hasMatch(mailaddress)) {
        _mailAddress = mailaddress;
      } else {
        _mailAddress = null; // Or set it to '' if that works better with your logic
        logger.d("Invalid email address");
      }
    });
  };*/




  bool get ifRegistrationAllowed => _isRegistationInProgress == false &&  _userFirstName != null && _userLastName != null && _mailAddress != null && _userFirstName!.isNotEmpty  && _userLastName!.isNotEmpty && _mailAddress!.isNotEmpty && _userFirstName!.length > 3;

  bool get isRegistrationInProgress => _isRegistationInProgress ;




  VoidCallback? get onRegistrationStart => !ifRegistrationAllowed ? null : ()
  {
      logger.d("Start user registration [$_userFirstName : $_mailAddress]") ;
      update(callback: () async{
        _isRegistationInProgress = true ;
        _userRegistrationModel = FiUserRegistrationModel(_userFirstName!, _userLastName!,_mailAddress!,launchingModel.platform,launchingModel.fcmToken);
        FiBackendResponse response = await authenticationApi.registerUser(_userRegistrationModel!) ;
        update(callback: (){
          _isRegistationInProgress = false ;
          if(response.successful())
          {
            applicationModel.currentState = FiApplicationStates.verificationState;
          }
          else
            {
              resources.storage.remove(kAccessNotificationToken);
              applicationModel.currentState = FiApplicationStates.userFailedLoginState;
            }
        });

      });

  };


  VoidCallback? get onResendCode => () {
    update(callback: () async {
      _resendCodeInProgress = true;
      _isResendAllowed = false;
      _timoutForEnableResendCode = 5*60 ; // 5 minutes
      FiBackendResponse response = await authenticationApi.registerUser(_userRegistrationModel!);
      _resendCodeInProgress = false;
      if (response.successful()) {
        logger.d("Resend successful, awaiting user verification.");
      } else {
        logger.d("Resend failed, please try again.");
      }
      startResendAllowTimer();
    });
  };


  bool get resendCodeAllowed => _resendCodeInProgress == false && _isResendAllowed;



/*
  VoidCallback? get onSendVerificationCode => (){
    update(callback: () async{
      _verificationInProgress = true ;
      FiUserVerificationModel ver = FiUserVerificationModel();
     // ver.mail = _userRegistrationModel?.mail ;
      ver.verification = _userRegistrationModel?.token;
      FiBackendResponse response = await authenticationApi.verificationUser(ver);
      if(response.successful()){
        applicationModel.currentContact = FiContact(type: FiContactPageType.current,user:await usersApi.loadUser(response.data!["token"])) ;
        await resources.storage.putString(kAccessNotificationToken, response.data!["token"]);
        applicationModel.currentState = FiApplicationStates.userSuccessLoginState ;
      }
      else
        {
          resources.storage.remove(kAccessNotificationToken);
          applicationModel.currentState = FiApplicationStates.userFailedLoginState;
        }
      update(callback: (){
        _verificationInProgress = false ;
      });
    });
  };
*/

  VoidCallback? get onSendVerificationCode => () {
    update(callback: () async {
      _verificationInProgress = true;
      bool verified = false;

      while (!verified) {
        FiUserVerificationModel ver = FiUserVerificationModel();
        ver.verification = _userRegistrationModel?.token;
        FiBackendResponse response = await authenticationApi.verificationUser(ver);

        if (response.successful()) {
          applicationModel.currentContact = FiContact(
              type: FiContactPageType.current,
              user: await usersApi.loadUser(response.data!["token"])
          );
          await resources.storage.putString(kAccessNotificationToken, response.data!["token"]);
          applicationModel.currentState = FiApplicationStates.userSuccessLoginState;
          verified = true;
        } else if (response.status != StatusCode.OK) {
          // Implement your waiting logic here - potentially including a sleep or backoff
          await Future.delayed(Duration(seconds: 10));  // Wait for 10 seconds before trying again
        }
      }

      update(callback: () {
        _verificationInProgress = false;
      });
    });
  };




  get sendVerificationIsAllowed => _verificationInProgress == false ;

  bool get verificationInProgress => _verificationInProgress;

  bool get resendCodeInProgress => _resendCodeInProgress ;






  void onRegistrationBack() async {
    await Future.delayed(const Duration(seconds: 1));
    applicationModel.currentState = FiApplicationStates.registrationState;
  }



  void onRegistrationBackFromFail() async {
    update(callback: ()
    {
      _userRegistrationModel?.firstName='';
      _userRegistrationModel?.lastName='';
      _userRegistrationModel?.mail='';
      _timoutForEnableResendCode = 5*60;
      _isRegistationInProgress = false;
      _verificationInProgress = false;
      _resendCodeInProgress = false;
      applicationModel.currentState = FiApplicationStates.grantPermissionState;
    });
  }


  void resetRegistrationState() {
    update(callback: () {
      _userFirstName = '';
      _userLastName = '';
      _mailAddress = '';
      _isRegistationInProgress = false;
      _verificationInProgress = false;
      _resendCodeInProgress = false;
    });
  }




  void onVerificationBack() async {
    await Future.delayed(const Duration(seconds: 1));
    applicationModel.currentState = FiApplicationStates.verificationState;
  }



  VoidCallback get onStartRegistration => () {
    applicationModel.currentState = FiApplicationStates.registrationState;
  };




  VoidCallback get onStartVerification => () {
        applicationModel.currentState = FiApplicationStates.verificationState;
      };




  VoidCallback get onStartUserSuccessLogin => () {
    applicationModel.currentState = FiApplicationStates.userSuccessLoginState;
  };


  String? get mailAddress => _mailAddress;
  String? get userName => _userFirstName;

  startResendAllowTimer(){
    if(!_isTimerStarted) {

      const oneSec = Duration(seconds: 1);
      _resendCodeTimer = Timer.periodic(oneSec, (Timer timer)
      {
          if (_timoutForEnableResendCode == 0) {
            update(callback: () {
              timer.cancel();
              _userVerificationCode = null ;
              _isResendAllowed = true;
              applicationModel.currentState = FiApplicationStates.userFailedLoginState ;
            //  _verificationSmsCodeController.clear() ;
            });
          } else {
            update(callback: () {
              _timoutForEnableResendCode--;
            });
          }
        },
      );
      _isTimerStarted = true ;
    }
  }

  String get resendTimerValue {
    int sec = _timoutForEnableResendCode % 60;
    int min = (_timoutForEnableResendCode / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }



  void stopVerifyCode()
  {
    if(_isTimerStarted) {
       _resendCodeTimer?.cancel();
      _isTimerStarted = false ;
    }
  }

}

FiRegistrationModel registrationModel = FiRegistrationModel();
