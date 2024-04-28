import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import '../../../backend/models/cx_user.dart';
import '../../../backend/models/fi_user_notification_settings.dart';
import '../../../backend/users/cx_users.dart';
import '../../../googleapis/cx_callendar_account.dart';
import '../../../googleapis/cx_googleapi_manager.dart';
import '../../../googleapis/fi_email_account.dart';
import '../../../models/main/base/fi_model.dart';
import '../../../models/main/fi_main_model.dart';
import '../../../models/main/fi_main_models_states.dart';
import '../../../utils/list/cx_multi_list_action.dart';

class CxSettingsTabModel extends FiModel {
  static String kEmails = "kEmails";

  static String kSocials = "kSocials";

  static String kCalendar = "kSCalendar";

  static String kFeedback = "kFeedback";

  static String kNotificationManualTime = "kNotificationManualTime";

  static String kNotificationRelatedToMe = "kNotificationRelatedTome";

  static String kNotificationAny = "kNotificationAny";

  final Map<String, bool> _notificationStates = {};

  final Map<String, List<dynamic>> _values = {};

  static final CxSettingsTabModel _instance = CxSettingsTabModel._internal();

  CxUserNotificationSettings? notificationSettings ;

  VoidCallback? refreshNotification ;

  CxSettingsTabModel._internal();

  factory CxSettingsTabModel() {
    _instance._values[kEmails] = <dynamic>[];
    _instance._values[kSocials] = <dynamic>[];
    _instance._values[kCalendar] = <dynamic>[];

    return _instance;
  }

  String get applicationVersionName => "1.0.0.0 DR1";

  CxMultiListAction get emailAction {
    final CxMultiListAction action = CxMultiListAction();
    action.action = () async {
      CxEmailAccount? account = await googleApiManager.addEmail();
      if (account != null) {
        action.add(account.email);
        _instance._values[kEmails]!.add(account);
        usersApi.addEmail(await account.toModel()) ;
      }
    };
    return action;
  }

  CxMultiListAction get calendarAction {
    final CxMultiListAction action = CxMultiListAction();
    action.action = () async {
      CxCalendarAccount? account = await googleApiManager.addCalendar();
      if (account != null) {
        action.add(account.email);
        _instance._values[kCalendar]!.add(account);
        usersApi.addCalendar(await account.toModel()) ;
      }
    };
    return action;
  }

  CxMultiListAction get socialAction {
    final CxMultiListAction action = CxMultiListAction();
    action.action = () async {
      // CxCalendarAccount? account = await googleApiManager.addCalendar();
      // if (account != null) {
      //   action.add(account.email);
      //   _instance._values[kCalendar]!.add(account);
      //   // await usersApi.addEmail(await account.toModel()) ;
      // }
    };
    return action;
  }

  List<String> get emailsAsString {
    List  accounts = _instance._values[kEmails]??<CxEmailAccount>[] ;
    List<String> list = <String>[];
    for(CxEmailAccount account in accounts) {
      list.add(account.email) ;
    }
    return list ;
  }

  List<String> get calendarsAsString {
    List  accounts = _instance._values[kCalendar]??<CxEmailAccount>[] ;
    List<String> list = <String>[];
    for(CxEmailAccount account in accounts) {
      list.add(account.email) ;
    }
    return list ;
  }



  void addEmailAccount(CxEmailAccount cxEmailAccount) {
    _instance._values[kEmails]?.add(cxEmailAccount) ;
  }

  void addCalendarAccount(CxEmailAccount cxEmailAccount) {
    _instance._values[kCalendar]?.add(cxEmailAccount) ;
  }

  void removeEmailAccount(String email){
    _instance._values[kEmails]?.removeWhere((element) => element.email == email) ;
  }

  void removeCalendarAccount(String email){
    _instance._values[kCalendar]?.removeWhere((element) => element.email == email) ;
  }

  void updateData(CxUser user) {
    if(user.emails.isNotEmpty){
      for(String email in user.emails) {
        CxEmailAccount accountEmail = CxEmailAccount(dbEmail: email);
        _instance._values[kEmails]!.add(accountEmail);
      }
    }

    if(user.calendars.isNotEmpty){
      for(String email in user.calendars) {
        CxEmailAccount accountEmail = CxEmailAccount(dbEmail: email);
        _instance._values[kCalendar]!.add(accountEmail);
      }
    }

    if(user.settings != null && user.settings!.isNotEmpty) {
      notificationSettings = CxUserNotificationSettings.fromJson(user.settings!);
    }
    else {
      notificationSettings = CxUserNotificationSettings(allowedFrom: 0, allowedTo: 0, relatedToMe: false, any: false);
    }

    _notificationStates[kNotificationManualTime] = notificationSettings?.isManualTimeSet??false ;
    _notificationStates[kNotificationRelatedToMe] =  notificationSettings?.relatedToMe??false ;
    _notificationStates[kNotificationAny] =  notificationSettings?.any??false ;
  }

  Future<void> load() async {
    CxEmailAccount? accountEmail = await googleApiManager.loadEmail();
    if (accountEmail != null) {
      _instance._values[kEmails]!.add(accountEmail);
      await usersApi.addEmail(await accountEmail.toModel());
    }
    CxCalendarAccount? accountCallendar = await googleApiManager.loadCalendar();
    if (accountCallendar != null) {
      _instance._values[kCalendar]!.add(accountCallendar);
      await usersApi.addCalendar(await accountCallendar.toModel());
    }
  }

  int get settingsCount => 10;





 /* VoidCallback get loginToOrganization => () async {
        applicationModel.setCurrentStateWithParams(CxApplicationStates.organizationLogin, {kBackState:CxApplicationStates.navigationScreen});
      };
*/
/*
  VoidCallback get inviteCoworker => () async {};
*/

  VoidCallback get showPersonalInformation => () async {
    applicationModel.currentState = FiApplicationStates.personalInformation ;
  };

 /* VoidCallback get showFeedbackScreen => () async {
        String email = Uri.encodeComponent("alexander@innovio.co.il");
        String subject = Uri.encodeComponent("Hello ConnectX");

        Uri mail = Uri.parse("mailto:$email?subject=$subject");
        if (await launchUrl(mail)) {
          //email app opened
        } else {
          //email app is not opened
        }
      };*/

  int valuesCount(String key) => _values[key]?.length ?? 0;

  List<String> valuesAsStrings(String key) {
    List<String> items = <String>[];
    if (_values.containsKey(key)) {
      Iterator<dynamic> it = _values[key]!.iterator;
      if (it.moveNext()) {
        do {
          dynamic current = it.current;
          if (current is CxEmailAccount) {
            items.add(current.email);
          }
          if (current is CxCalendarAccount) {
            items.add(current.email );
          }
        } while (it.moveNext());
      }
    }
    return items;
  }

  bool notificationStateFor(String key) {
    if (!_notificationStates.containsKey(key)) {
      _notificationStates[key] = false;
    }
    return _notificationStates[key]!;
  }

  void setNotificationState(String key, bool value) {
    if(CxSettingsTabModel.kNotificationManualTime == key && !value){
      notificationSettings?.allowedTo = 0 ;
      notificationSettings?.allowedFrom = 0 ;
    }
    update(callback: () {
      _notificationStates[key] = value ;
      refreshNotification?.call() ;
    });
  }

  bool get isManualTimeSetEnabled => _notificationStates[CxSettingsTabModel.kNotificationManualTime]??false ;

  String valueAtIndex(String key, int index) {
    if (valuesCount(key) > index) {
      var item = _values[key]![index];
      if (item is CxEmailAccount) {
        CxEmailAccount account = item;
        return account.account != null ? account.account!.email : account.email ;
      }
      if (item is CxCalendarAccount) {
        CxCalendarAccount account = item;
        return account.account != null ? account.account!.email : account.email;
      }
      return item;
    }
    return "";
  }

  void setNotificationRefreshCallback(VoidCallback? refresh) {
    refreshNotification = refresh ;
  }


}

CxSettingsTabModel settings = CxSettingsTabModel();
