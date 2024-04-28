import 'dart:async';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import '../../backend/authentication/fi_authentication.dart';
import '../../backend/models/cx_backend_response.dart';
import '../../backend/models/cx_user_registration_model.dart';
import '../../backend/models/fi_user_verification_model.dart';
import '../../backend/users/cx_users.dart';
import '../../models/main/base/fi_model.dart';
import '../../models/main/fi_main_model.dart';
import '../../models/main/fi_main_models_states.dart';
import '../../utils/fi_log.dart';
import '../../utils/fi_resources.dart';
import '../contacts/cx_contacts_tab_widget.dart';
import '../launching/fi_launching_model.dart';
import '../navigationbar/contacts/fi_contacts.dart';

class CxRegistrationModel extends FiModel {
  static final CxRegistrationModel _instance = CxRegistrationModel._internal();
  Timer? _resendCodeTimer;
  int _timoutForEnableResendCode = 5 * 60;
  bool _isTimerStarted = false ;
  String? _userFirstName ;
  String? _userLastName ;
  String? _userVerificationCode ;
  bool _isResendAllowed = false ;
  bool _isSendAllowed = false ;
  //String? _userPhone ;
  String? _mailAddress ;
  bool _verificationInProgress = false ;
  bool _resendCodeInProgress = false ;
  bool _isRegistationInProgress = false ;
 // String? _receivedSmsCode ;
 // List<String>? _digits ;
  //final TextEditingController _verificationSmsCodeController  =  TextEditingController(text:"0000");
  CxUserRegistrationModel? _userRegistrationModel;
  CxRegistrationModel._internal();

  factory CxRegistrationModel() {
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
//TODO: check if the mail is legal
  bool get ifRegistrationAllowed => _isRegistationInProgress == false &&  _userFirstName != null && _userLastName != null && _mailAddress != null && _userFirstName!.isNotEmpty  && _userLastName!.isNotEmpty && _mailAddress!.isNotEmpty && _userFirstName!.length > 3 && _mailAddress!.length > 5;

  bool get isRegistrationInProgress => _isRegistationInProgress ;




  VoidCallback? get onRegistrationStart => !ifRegistrationAllowed ? null : ()
  {
      logger.d("Start user registration [$_userFirstName : $_mailAddress]") ;
      update(callback: () async{
        _isRegistationInProgress = true ;
        _userRegistrationModel = CxUserRegistrationModel(_userFirstName!, _userLastName!,_mailAddress!,launchingModel.platform,launchingModel.fcmToken);
        CxBackendResponse response = await authenticationApi.registerUser(_userRegistrationModel!) ;
        update(callback: (){
          _isRegistationInProgress = false ;
          if(response.successful())
          {
            applicationModel.currentState = FiApplicationStates.verificationState;
          }
          else
            {
              //TODO
            }
        });

      });

  };//Checking the mail, and the send him to verification to confirm phone

/*  VoidCallback? get onResendCode => ()
  {
    update(callback: () async {
      _resendCodeInProgress = true ;
      _isResendAllowed = false;
      _timoutForEnableResendCode = 5 * 60;
      CxBackendResponse response = await authenticationApi.registerUser(_userRegistrationModel!) ;
      _resendCodeInProgress = false ;
      if(response.successful()){
        applicationModel.currentState = FiApplicationStates.userSuccessLoginState ;
      }
      //stopVerifySmsCode();
      startResendAllowTimer();
    });
  };*/



/*
  bool get resendCodeAllowed => _resendCodeInProgress == false && _isResendAllowed;
*/



  VoidCallback? get onSendVerificationCode => (){
    update(callback: () async{
      _verificationInProgress = true ;
      CxUserVerificationModel ver = CxUserVerificationModel();
      ver.mail = _userRegistrationModel?.mail ;
      //ver.verification = _userVerificationCode ;
      CxBackendResponse response = await authenticationApi.verificationUser(ver) ;//TODO: REMOVE THE ARG ver
      if(response.successful()){
        applicationModel.currentContact = CxContact(type: CxContactPageType.current,user:await usersApi.loadUser(response.data!["token"])) ;
        await resources.storage.putString(kAccessNotificationToken, response.data!["token"]);
        applicationModel.currentState = FiApplicationStates.userSuccessLoginState ;
      }
      else
        {
          //TODO : SEND TO FAILED WIDGET (REGISTRATION)
        }
      update(callback: (){
        _verificationInProgress = false ;
      });
    });
  };

  get sendVerificationIsAllowed => _verificationInProgress == false ;



/*  ValueChanged<String> get onInputVerificationModeComplete => (verificationCode){
    update(callback: () {
     // _userVerificationCode = verificationCode ;
      _isSendAllowed = _userVerificationCode != null && _userVerificationCode!.isNotEmpty && _userVerificationCode!.length == 4 ;
    });
  };*/


  bool get verificationInProgress => _verificationInProgress;

  bool get resendCodeInProgress => _resendCodeInProgress ;

/*
  TextEditingController get verificationSmsCodeController => _verificationSmsCodeController;
*/

  /*List<String>? get digits {
    return _digits ;
  }*/






  void onRegistrationBack() async {
    await Future.delayed(const Duration(seconds: 1));
    applicationModel.currentState = FiApplicationStates.registrationState;
  }









  void onVerificationBack() async {
    await Future.delayed(const Duration(seconds: 1));
    applicationModel.currentState = FiApplicationStates.verificationState;
  }


/*  void onGuidanceIntroBack() async {
    await Future.delayed(const Duration(seconds: 1));
    applicationModel.currentState = FiApplicationStates.guidanceIntroState;
  }*/




  VoidCallback get onStartRegistration => () {
    applicationModel.currentState = FiApplicationStates.registrationState;
  };




  VoidCallback get onStartVerification => () {
        applicationModel.currentState = FiApplicationStates.verificationState;
      };




  VoidCallback get onStartUserSuccessLogin => () {
    applicationModel.currentState = FiApplicationStates.userSuccessLoginState;
  };


/*
  VoidCallback get onGuidanceIntroStateLogin => () {
    applicationModel.currentState = FiApplicationStates.guidanceIntroState;
  };*/


  String? get mailAddress => _mailAddress;
  String? get userName => _userFirstName;

  startResendAllowTimer(){
    if(!_isTimerStarted) {

      const oneSec = Duration(seconds: 1);
      _resendCodeTimer = Timer.periodic(oneSec,
            (Timer timer) {
          if (_timoutForEnableResendCode == 0) {
            update(callback: () {
              timer.cancel();
              _userVerificationCode = null ;
              _isResendAllowed = true;
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
/*
  void useSmsCode(String smsCode) {

    update(callback: (){
      _receivedSmsCode = smsCode ;
      if(_receivedSmsCode != null) {
        _receivedSmsCode = smsCode ;
        CharacterRange it = _receivedSmsCode!.characters.iterator;
        //_digits = <String>[];
        if(it.moveNext()){
          do{
           // _digits!.add(it.current);
          }
          while(it.moveNext());
          _userVerificationCode = smsCode ;
          _isSendAllowed = _userVerificationCode != null && _userVerificationCode!.isNotEmpty && _userVerificationCode!.length == 4 ;
        }
      }
    });
  }*/
}

CxRegistrationModel registrationModel = CxRegistrationModel();
