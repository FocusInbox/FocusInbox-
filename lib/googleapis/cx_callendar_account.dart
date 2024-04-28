//import 'package:connectx/utils/cx_log.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../backend/models/cx_user_email.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

import 'fi_authentication_client.dart';

class CxCalendarAccount {
  GoogleSignInAccount? account;
  calendar.CalendarApi? _calendarApi ;
  String? dbEmail ;
  CxCalendarAccount({this.account,this.dbEmail});

  String get email {
    return dbEmail!= null && dbEmail!.trim().isNotEmpty ? dbEmail! : account?.email??"" ;
  }

  Future<void> connectToCalendar() async {
    try{
      if(account != null) {
        var headers = await account!.authHeaders;
        final authenticateClient = GoogleAuthClient(headers);
        _calendarApi = calendar.CalendarApi(authenticateClient);
       // logger.d("Calendar = $_calendarApi");
      }

    }
    catch(err, stack){
     // logger.d("Error: $err, stack = $stack");
    }
  }

  Future<CxUserEmail> toModel() async {
    if(account != null) {
      var headers = await account!.authHeaders;
      CxUserEmail email = CxUserEmail(email: account!.email, headers: headers);
      return email;
    }
    return  CxUserEmail(email: email, headers: null);
  }
}
