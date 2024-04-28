import 'package:flutter/cupertino.dart';

typedef CustomWidget = Widget Function(BuildContext context);

class CxCustomExtendedWidget extends StatefulWidget{
  final CustomWidget childBuilder;

   CxCustomExtendedWidget({super.key,required this.childBuilder});

  VoidCallback?  onRefresh;

  @override
  State<StatefulWidget> createState() => _CxCustomExtendedWidgetState();

  void update() {
    onRefresh?.call() ;
  }

}

class _CxCustomExtendedWidgetState extends State<CxCustomExtendedWidget>{

  @override
  void initState() {
    widget.onRefresh = (){
      setState(() {

      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context)  =>  widget.childBuilder(context) ;

}