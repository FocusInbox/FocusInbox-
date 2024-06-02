import 'package:flutter/cupertino.dart';

import '../../../utils/fi_display.dart';
import '../../../utils/cx_text_utils.dart';

class CxAiChatItem {
  bool my;

  String question;

  String _answer = "";

  int lines = 1;

  CxAiChatItem(this.my, this.question);

  String maxString = "";
  double maxStringWidth = 0 ;
  double maxStringWidthOnDisplay = toX(100) ;
  double width = 0 ;



  static var style = TextStyle(
    fontSize: toY(12),
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
  );

  set answer(String data) {
     _answer = "$_answer$data";
     List<String> allLines = _answer.split("\n");

     allLines.removeWhere((element) => element.trim() == '\n') ;

     for(int i = 0 ; i < allLines.length ;i++){
       double lineWidth  = FiTextUtils.stringWidth(allLines[i],CxAiChatItem.style) ;
       if(lineWidth > width){
         width = lineWidth < maxStringWidthOnDisplay ? lineWidth : maxStringWidthOnDisplay ;
       }
       if(width == maxStringWidthOnDisplay) break ;
     }

     lines = allLines.length ;


  }

  String get answer => _answer;
}
