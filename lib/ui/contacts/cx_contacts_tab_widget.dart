import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import '../../utils/fi_display.dart';
import '../base/fi_base_state.dart';
import '../base/fi_base_widget.dart';
import 'cx_contacts_tab_model.dart';

enum CxContactPageType {current, private, divider }

class CxContactsTabWidget extends FiBaseWidget {
  const CxContactsTabWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CxContactsTabState();
}

class _CxContactsTabState extends FiBaseState<CxContactsTabWidget> {
  int _selectedIndex = 0;
  final CarouselController _buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    contacts.setState(this);
  }

  @override
  void dispose() {
    contacts.setState(null);
    super.dispose();
  }

  @override
  Widget get content => ConstraintLayout(
        width: matchParent,
        height: matchParent,
        children: [
          Column(children: [
            CarouselSlider.builder(
              itemCount:contacts.pageCount ,
              carouselController: _buttonCarouselController,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => contacts.pageAtIndex(itemIndex),
              options: CarouselOptions(
                  height: toY(822),
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  aspectRatio: 1,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      display.closeKeyboard() ;
                      contacts.currentPageIndex = index ;
                      _selectedIndex = index;
                    });
                  }),
            )
          ]).applyConstraint(left: parent.left, right: parent.right, top: parent.top, bottom: parent.bottom, width: matchConstraint, height: matchConstraint),
        ],
      );

}
