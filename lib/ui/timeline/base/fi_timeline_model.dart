import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/main/base/fi_model.dart';
import '../../../models/main/fi_main_models_states.dart';
import '../../../utils/fi_resources.dart';
import '../../navigationbar/contacts/fi_contacts.dart';



class CxTimelineModel extends FiModel {



  CxTimelineModel();

  TextEditingController _searchController = TextEditingController();

  String get title => "" ;

  String get name => "David Cohen";

  String get phone => "+972(54)664166";

  String get occupation => "COO - Jhonson Control" ;

  //List<CxGroup> get groups => groupsModel.groups;

  List<CxContact> get members => <CxContact>[] ;

  //final List<CxTimelineItem> _timelineItems = <CxTimelineItem>[] ;





  VoidCallback get showFullTimeline => (){};

  VoidCallback get showOutgoingInteractionOnly => (){};


  VoidCallback get showIncomingInteractionOnly => (){};

  VoidCallback get clearFilters => (){};

  bool get logoVisible => false;

  Widget get logo => Container();

//  get count => _timelineItems.length;

  FiApplicationStates get backState => FiApplicationStates.mineTimeline;

  bool get pageMenuSupported => false;

  TextEditingController get searchController => _searchController;

  ValueChanged<String> get onSearch => (value){};

  bool get inSearch => false ;

  VoidCallback?  get stopSearch => (){};

  String get timelineName => localise("my_timeline");

  //CxTimelineItem itemAtIndex(int index) => _timelineItems[index];

  updateImage(XFile file){}
}