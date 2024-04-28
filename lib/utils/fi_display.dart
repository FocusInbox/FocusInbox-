
import 'package:flutter/cupertino.dart';
import 'fi_resources.dart';

class CxDisplay {
  static final CxDisplay _instance = CxDisplay._internal();
  late double width ;
  late double height ;

  late double realWidth ;
  late double realHeight ;

  final double designWidth  = 414;
  final double designHeight = 896;

  late double devicePixelRatio ;

  CxDisplay._internal();

  factory CxDisplay(){
    return _instance ;
  }

  closeKeyboard(){
    FocusScopeNode currentFocus = FocusScope.of(resources.context!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void init(BuildContext context) {
    var media = MediaQuery.of(context) ;
    width = media.size.width;
    height = media.size.height;
    devicePixelRatio = media.devicePixelRatio ;
    realWidth = width*devicePixelRatio;
    realHeight = height*devicePixelRatio;
  }
}

CxDisplay display = CxDisplay();

double toX(double value) => (display.width*value)/display.designWidth ;

double toY(double value) => (display.height*value)/display.designHeight ;

double centerOnDisplayByWidth(double widgetWidth) => display.width/2 - widgetWidth/2 ;

