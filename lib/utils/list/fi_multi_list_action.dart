

import 'package:flutter/cupertino.dart';

class CxMultiListAction {
  VoidCallback? action ;
  ValueChanged<dynamic>? update ;

  CxMultiListAction({ this.action});

  add(String value) {
    update?.call(value) ;
  }
}