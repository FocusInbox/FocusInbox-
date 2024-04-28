
import 'package:flutter/cupertino.dart';



class CxDialogWidget {
  final Widget _dialog ;
  double left, top,width,height ;
  bool dismissable = true ;

  CxDialogWidget(this._dialog,{required this.left,required this.top,required this.width,required this.height, this.dismissable = true}) ;

  Widget get dialog  => _dialog ;
}


