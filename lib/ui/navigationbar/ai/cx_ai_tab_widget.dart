import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../../utils/cx_audio_utils.dart';
import '../../../utils/cx_text_utils.dart';
import '../../../utils/fi_display.dart';
import '../../../utils/fi_log.dart';
import '../../../utils/fi_resources.dart';
import '../../base/fi_base_widget.dart';
import '../contacts/fi_contacts_tab_model.dart';
import '../../utils/fi_ui_elements.dart';
import '../cx_navigation_bar_model.dart';
import 'cx_ai_bubble_clipper.dart';
import 'cx_ai_chat_item.dart';
import 'cx_ai_model.dart';
import '../../base/fi_base_state.dart';

class CxAiTabWidget extends FiBaseWidget {
  const CxAiTabWidget({super.key});

  @override
  State<StatefulWidget> createState() => CxAiTabState();
}

class CxAiTabState extends FiBaseState<CxAiTabWidget> with SingleTickerProviderStateMixin {
  int _inputLineNumber = 1;
  Size? textSize;
  double inputHeight = 0;
  bool _keyboardIsOpen = false;

  late StreamSubscription<bool> keyboardSubscription;
  final ScrollController _controller = ScrollController();
  final FocusNode _inputFocusMode = FocusNode();

  @override
  void initState() {
    super.initState();
    ai.setState(this);
    var keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardIsOpen = keyboardVisibilityController.isVisible;
    // Subscribe
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardIsOpen = visible;
      });
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    ai.setState(null);
    super.dispose();
  }

  @override
  // TODO: implement content
  Widget get content => InkWell(
      // to dismiss the keyboard when the user tabs out of the TextField
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _keyboardIsOpen = false;
        });
      },
      child: Stack(
        children: [
          Positioned(
              top: toY(60),
              left: toX(20),
              width: toX(374),
              height: toY(732),
              child: Container(
                width: toX(374),
                height: toY(762),
                decoration: ShapeDecoration(
                  color: const Color(0xFF292D36),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFF0677E8)),
                    borderRadius: BorderRadius.circular(toX(20)),
                  ),
                ),
                child: _aiContent(),
              ))
        ],
      ));

  Widget _aiContent() {
    return Stack(
      children: [
        Positioned(top: toY(20), left: toX(20), width: toX(32), height: toX(32), child: InkWell(onTap: navigationBar.closeAiDialog, child: Image(image: const AssetImage("assets/images/exit_button.png"), width: toX(32), height: toX(32)))),
        Positioned(top: toY(20), left: toX(313), width: toX(41), height: toX(41), child: uiElements.popupMenu(_pageMenu(), Image(image: const AssetImage("assets/images/menu_dots.png"), width: toX(32), height: toX(32)), BoxConstraints.tightFor(width: toX(170)), Offset(0, toY(30)))),
        Positioned(
            top: toY(_keyboardIsOpen ? 20 : 114),
            left: toX(62),
            width: toX(250),
            height: toX(29),
            child: Text(
              localise("ask_me"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: toY(24),
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            )),
        if (!ai.inChat) Positioned(top: toY(_keyboardIsOpen ? 100 : 178), left: centerOnDisplayByWidth(165), width: toX(139), height: toX(164), child: Image(image: const AssetImage("assets/images/ai_man_big.png"), width: toX(139), height: toX(164))),
        if (!ai.inChat)
          Positioned(
              top: toY(_keyboardIsOpen ? 310 : 419),
              left: toX(22),
              width: toX(344),
              height: toX(102),
              child: Text(
                localise("ai_bob_text"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFE4E5E6),
                  fontSize: toY(14),
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              )),
        if (ai.inChat) Positioned(top: toY(170), width: toX(374), height: toY(_keyboardIsOpen ? 371 : 460), child: _chat()),
        Positioned(bottom: toY(_keyboardIsOpen ? 200 : 20), left: toX(15), width: toX(344), child: inputQuestionWidget())
      ],
    );
  }

  void scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _chat() {
    return ListView.builder(controller: _controller, itemCount: ai.questionsCount, itemBuilder: (BuildContext context, int index) => chatItem(index));
  }

  Widget chatItem(int index) {
    Color myColor = const Color.fromRGBO(45, 57, 97, 1);
    Color bobColor = const Color.fromRGBO(94, 161, 174, 1);
    CxAiChatItem item = ai.items[index];

    return Padding(
        padding: EdgeInsets.only(left: toX(10), right: toX(10)),
        child: Container(
            //width: display.width,
            //height: wrapContent,
            alignment: item.my ? Alignment.topLeft : Alignment.topRight,
            padding: EdgeInsets.zero,
            child: ChatBubble(
                clipper: CxAiBubbleClipper(),
                alignment: item.my ? Alignment.topLeft : Alignment.topRight,
                margin: const EdgeInsets.only(top: 20),
                backGroundColor: item.my ? myColor : bobColor,
                child: Container(
                  // constraints: BoxConstraints(
                  //   maxWidth: MediaQuery.of(context).size.width,
                  // ),
                  decoration: ShapeDecoration(
                      color: item.my ? myColor : bobColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(toX(14)),
                      )),
                  child: ConstraintLayout(
                    children: [
                      //).applyConstraint(left: parent.left,right: parent.right,top: parent.top,bottom: parent.bottom),
                      Image(
                        image: item.my ? contacts.myImage : const AssetImage("assets/images/nb_man_icon.png"),
                        width: toX(44),
                        height: toX(54),
                      ).applyConstraint(left: parent.left, top: parent.top, width: toX(44), height: toX(54))
                    ],
                  ),
                ))));
  }

  // Widget chatItem(int index) {
  //   ConstraintId userImageId = ConstraintId("userImageId_$index");
  //   ConstraintId userTitleId = ConstraintId("userTitleId_$index");
  //   Color myColor = const Color.fromRGBO(45, 57, 97, 1);
  //   Color bobColor = const Color.fromRGBO(94, 161, 174, 1);
  //   CxAiChatItem item = ai.items[index];
  //
  //   Size boxSize = CxTextUtils.calculateTextBoxSize(
  //       item.my ? item.question : item.question,
  //       TextStyle(
  //         fontSize: toY(12),
  //         fontFamily: 'Roboto',
  //         fontWeight: FontWeight.w500,
  //       ),
  //       toX(300));
  //
  //   double height = boxSize.height;
  //   double width = boxSize.width;
  //
  //   width += toX(102);
  //
  //   height += toY(67);
  //
  //   if (!item.my) {
  //     //width = toX(102);
  //     Size boxSizeH = CxTextUtils.calculateTextBoxSize(
  //         "W",
  //         TextStyle(
  //           fontSize: toY(12),
  //           fontFamily: 'Roboto',
  //           fontWeight: FontWeight.w500,
  //         ),
  //         toX(300));
  //
  //     height = item.lines * boxSizeH.height;
  //     height += toY(67);
  //     width += item.width;
  //     //logger.d("Lines $lines, height = $height") ;
  //   }
  //
  //   return Padding(
  //       padding: item.my ? EdgeInsets.only(left: toX(20)) : EdgeInsets.only(right: toX(20), top: toY(20)),
  //       child: Align(
  //           alignment: item.my ? Alignment.centerLeft : Alignment.centerRight,
  //           child: Container(
  //             width: width,
  //             height: height,
  //             decoration: ShapeDecoration(
  //               color: item.my ? myColor : bobColor,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(toX(14)),
  //               ),
  //             ),
  //             child: ConstraintLayout(
  //               width: width,
  //               height: height,
  //               children: [
  //                 Padding(
  //                     padding: EdgeInsets.only(left: toX(7), top: toY(10)),
  //                     child: Image(
  //                       image: item.my ? contacts.myImage : const AssetImage("assets/images/nb_man_icon.png"),
  //                       width: toX(44),
  //                       height: toX(54),
  //                     )).applyConstraint(id: userImageId, left: parent.left, top: parent.top, width: toX(44), height: toX(54)),
  //                 Padding(
  //                     padding: EdgeInsets.only(left: toX(11), top: toY(10)),
  //                     child: Text(
  //                       item.my ? localise("you") : localise("bob"),
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: toY(14),
  //                         fontFamily: 'Roboto',
  //                         fontWeight: FontWeight.w700,
  //                       ),
  //                     )).applyConstraint(id: userTitleId, left: userImageId.right, top: userImageId.top),
  //                 if (item.my)
  //                   Padding(
  //                       padding: EdgeInsets.only(left: toX(11), top: toY(10)),
  //                       child: Text(
  //                         item.question,
  //                         style: TextStyle(
  //                           color: const Color(0xFFE5E5E5),
  //                           fontSize: toY(12),
  //                           fontFamily: 'Roboto',
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       )).applyConstraint(left: userTitleId.left, top: userTitleId.bottom),
  //                 if (!item.my)
  //                   Padding(
  //                       padding: EdgeInsets.only(left: toX(11), top: toY(10)),
  //                       child: Text(
  //                         item.answer,
  //                         style: TextStyle(
  //                           color: const Color(0xFFE5E5E5),
  //                           fontSize: toY(12),
  //                           fontFamily: 'Roboto',
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       )).applyConstraint(left: userTitleId.left, top: userTitleId.bottom),
  //                 if (!item.my)
  //                   Padding(
  //                           padding: EdgeInsets.only(right: toX(11), top: toY(10)),
  //                           child: uiElements.popupMenu(
  //                               _bobMenuItems(),
  //                               Image(
  //                                 image: const AssetImage("assets/images/menu_dots.png"),
  //                                 width: toX(15),
  //                                 height: toY(42),
  //                               ),
  //                               BoxConstraints.tightFor(width: toX(190)),
  //                               Offset(0, toY(30))))
  //                       .applyConstraint(right: parent.right, top: userTitleId.top, width: toX(15), height: toY(52)),
  //               ],
  //             ),
  //           )));
  // }

  Widget inputQuestionWidget() {
    return Container(
      width: toX(344),
      height: _inputLineNumber == 1
          ? toY(72)
          : _inputLineNumber < 4
              ? _inputLineNumber * 48
              : 4 * 48, //inputHeight == 0 ? toY( 72) : inputHeight* 20,
      decoration: ShapeDecoration(
        color: const Color(0xFF454A59),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(toX(12.84)),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              top: toY(4),
              left: toX(2),
              child: InkWell(
                  onTapDown: _startSpeechListening,
                  onTapUp: _stopSpeechListening,
                  child: Image(
                    image: const AssetImage("assets/images/mic.png"),
                    width: toX(62),
                    height: toX(62),
                  ))),
          Positioned(
            top: toY(10),
            left: toX(66),
            width: toX(270),
            child: input(),
          ),
        ],
      ),
    );
  }

  GestureTapDownCallback get _startSpeechListening => (details) async {
        bool result = await audioUtils.startSpeechListening((result) {
          ai.update(callback: () {
            onTypedQuestion.call(result);
            logger.d("Speech: $result");
          });
        });

        logger.d("Speech: start result == $result");
        if (result) {
          ai.update(callback: () {
            _inputLineNumber = 1;
            inputHeight = 0;
          });
        }
      };

  GestureTapUpCallback get _stopSpeechListening => (details) async {
        await audioUtils.stopSpeechListening();
        ai.update(callback: () {
          _inputLineNumber = 1;
          inputHeight = 0;
          _inputFocusMode.unfocus();

          _keyboardIsOpen = false;
          ai.ask.call();
          logger.d("Speech: stopped");
        });
      };

  Widget input() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        inputHeight = constraints.maxHeight;
        return uiElements.inputField(
            focusNode: _inputFocusMode,
            hintText: localise("write_now"),
            maxLine: _inputLineNumber < 4 ? null : 4,
            keyboardType: TextInputType.multiline,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: toY(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            onChange: onTypedQuestion,
            sufficsIconClick: () {
              ai.update(callback: () {
                _inputLineNumber = 1;
                inputHeight = 0;
              });
              ai.ask.call();
            },
            suffixIcon: Image(
              image: const AssetImage("assets/images/ask.png"),
              width: toX(22),
              height: toY(20),
            ));
      },
    );
  }

  ValueChanged<String> get onTypedQuestion => (question) {
        ai.onQuestion.call(question);

        int lines = FiTextUtils.lineNumbers(
            question,
            TextStyle(
              fontSize: toY(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ));

        textSize = FiTextUtils.calculateTextBoxSize(
            question,
            TextStyle(
              fontSize: toY(14),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
            toX(250));

        if (_inputLineNumber != lines) {
          if (lines == 0) {
            ai.update(callback: () {
              _inputLineNumber = 1;
            });

            return;
          }

          ai.update(callback: () {
            logger.d("Update size from $_inputLineNumber to $lines");
            _inputLineNumber = lines;
          });
        }
      };

  List<PopupMenuItem> _pageMenu() {
    List<PopupMenuItem> list = <PopupMenuItem>[];
    list.add(uiElements.pageMenuItemWithSubtitle(
        localise("open_history"),
        localise("all_searches_in_history"),
        Image(
          image: const AssetImage("assets/images/ai_history.png"),
          width: toX(20),
          height: toY(18),
        ),
        ai.loadHistory));
    list.add(uiElements.pageMenuItemWithSubtitle(
        localise("clear_history"),
        localise("clear_all_search_history"),
        Image(
          image: const AssetImage("assets/images/clear_history.png"),
          width: toX(20),
          height: toY(18),
        ),
        ai.clearHistory));
    return list;
  }

  List<PopupMenuItem> _bobMenuItems() {
    List<PopupMenuItem> list = <PopupMenuItem>[];
    list.add(uiElements.pageMenuItem(
        localise("share"),
        Image(
          image: const AssetImage("assets/images/share.png"),
          width: toX(20),
          height: toY(18),
        ),
        () {}));
    list.add(uiElements.pageMenuItem(
        localise("tag_contact"),
        Image(
          image: const AssetImage("assets/images/tag_contact.png"),
          width: toX(20),
          height: toY(18),
        ),
        () {}));
    list.add(uiElements.pageMenuItem(
        localise("add_to_insights"),
        Image(
          image: const AssetImage("assets/images/insign.png"),
          width: toX(20),
          height: toY(18),
        ),
        () {}));
    list.add(uiElements.pageMenuItem(
        localise("add_to_tasks"),
        Image(
          image: const AssetImage("assets/images/add_to_task.png"),
          width: toX(20),
          height: toY(18),
        ),
        () {}));
    return list;
  }
}

/*
T
 */
