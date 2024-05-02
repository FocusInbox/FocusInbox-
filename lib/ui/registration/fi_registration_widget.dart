import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import '../../utils/fi_display.dart';
import '../../utils/fi_resources.dart';
import '../base/fi_base_state.dart';
import '../base/fi_base_widget.dart';
import '../utils/fi_ui_elements.dart';
import 'fi_registration_model.dart';

class CxRegistrationWidget extends FiBaseWidget {
  const CxRegistrationWidget({super.key});

  @override
  State<StatefulWidget> createState() => _CxRegistrationState();
}

class _CxRegistrationState extends FiBaseState<CxRegistrationWidget> {
  @override
  void initState() {
    super.initState();
   // registrationModel = CxRegistrationModel(); // Initialize the registration model
    registrationModel.setState(this);
  }

  @override
  void dispose() {
    registrationModel.resetState(this); // Reset the state in the registration model when disposing
    super.dispose();
  }


  @override
  @protected
  Widget get content {
    return Stack(
      children: [
        Positioned(
            left: 0,//centerOnDisplayByWidth(toX(336)),
            right:0,
            top: toY(171.81),
            child: Center(child:Text(localise("welcome_to"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: toY(38),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1.52,
                    height: toY(1.2)
                )))),
        Positioned(
            left: toX(35),
            right: toX(35),
            top: toY(309),
            // width: toX(343.9997),
            // height: toY(65.5238),
            child:Center(child: uiElements.inputField(
                onChange:registrationModel.onUserFirstNameChange,
                prefixIcon: CxUiElements.inputNameIcon,
                hintText:localise("enter_your_first_name"),
                hintStyle: const TextStyle(
              color: Color(0xFFC2C3CB),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ))
        )),
        Positioned(
            left: toX(35),
            right: toX(35),
            top: toY(398),
            // width: toX(343.9997),
            // height: toY(65.5238),
            child:Center(child: uiElements.inputField(onChange:registrationModel.onUserLastNameChange,
                prefixIcon: CxUiElements.inputNameIcon,
                hintText:localise("enter_your_last_name"),
                hintStyle: const TextStyle(
              color: Color(0xFFC2C3CB),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ))
            )),
        Positioned(
            left: toX(35),
            right: toX(35),
            top: toY(488),

            child: Center(child: uiElements.inputField(keyboardType:TextInputType.emailAddress,
                onChange:registrationModel.onMailAddressChange,
                prefixIcon: CxUiElements.inputEmailIcon,
                hintText:localise("enter_your_email"),
                hintStyle: const TextStyle(
              color: Color(0xFFC2C3CB),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ))
        )),
        Positioned(
            left: display.width / 2 - toX(328) / 2,
            top: toY(650),
            width: toX(328),//CHANGED FROM 228
            height: toY(139),//CHANGED FROM 79
            child: _terms()),
        Positioned(
            left: display.width / 2 - toX(343.9997) / 2,
            bottom: toY(30),
            width: toX(343.9997),
            height: toY(65.5238),
            child: uiElements.button(localise("regestration"),
                registrationModel.onRegistrationStart,
                enabled: registrationModel.ifRegistrationAllowed,
                progressVisible: registrationModel.isRegistrationInProgress))
      ],
    );
  }


  Widget _terms(){
    return  SizedBox(
      width: toX(228),
      height: toY(79),
      child:  Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: localise("by_click"),
              style: const TextStyle(
                color: Color(0xBFACADB9),
                fontSize: 14,//CHANGED FROM 18
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
               // height: 1.5,
                letterSpacing: 0.54,
              ),
            ),
             TextSpan(
              text: localise("terms"),
              style: const TextStyle(
                color: Color(0xFF0677E8),
                fontSize: 14,//CHANGED FROM 18
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
               // height: 1.5,
                letterSpacing: 0.54,
              ),
            ),
            TextSpan(
              text: localise("of_context"),
              style: const TextStyle(
                color: Color(0xBFACADB9),
                fontSize: 14,//CHANGED FROM 18
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                //height: 1.5,
                letterSpacing: 0.54,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

/*  Widget phoneLogin() {
    return Container(
        width: display.width,
        height:  display.height,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(toX(20))),
        ),
        child: Stack(children: [
          //Button
          Positioned(
            top: toX(678),
            left: 35,
            child: SizedBox(
              width: 343.9999694824219,
              height: 65.5238037109375,
              child: GestureDetector(
                onTap: registrationModel.onStartVerification,
                child: Stack(
                  children: [
                    // Button
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: toX(343.9999694824219),
                        height: 65.5238037109375,
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(toX(14))),
                          color: Color.fromRGBO(6, 119, 232, 1),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 25.29296875,
                      left: 130,
                      child: Text(
                        'Verification',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(243, 245, 246, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          //Full Name + Phone Number + Welcome
          Positioned(
              top: 171.8095703125,
              left: 35,
              child: SizedBox(
                  width: 343.9999694824219,
                  height: 311.7152099609375,
                  child: Stack(children: [
                    //Full Name
                    Positioned(
                      top: 157.1904296875,
                      left: 0,
                      child: SizedBox(
                        width: 343.9999694824219,
                        height: 65.5238037109375,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 343.9999694824219,
                                height: 65.5238037109375,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.84000015258789),
                                    topRight: Radius.circular(12.84000015258789),
                                    bottomLeft: Radius.circular(12.84000015258789),
                                    bottomRight: Radius.circular(12.84000015258789),
                                  ),
                                  color: Color.fromRGBO(41, 44, 53, 1),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 28,
                              left: 65,
                              child: SizedBox(
                                width: 140,
                                height: 21,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Text(
                                        'Enter your Full Name',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromRGBO(194, 195, 203, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              left: 25,
                              child: Image.asset(
                                "assets/images/_inputNameIcon.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Phone Number
                    Positioned(
                      top: 246.19140625,
                      left: 0,
                      child: SizedBox(
                        width: 343.9999694824219,
                        height: 65.5238037109375,
                        child: Stack(children: [
                          Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                  width: 343.9999694824219,
                                  height: 65.5238037109375,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(12.84000015258789),
                                      topRight:
                                          Radius.circular(12.84000015258789),
                                      bottomLeft:
                                          Radius.circular(12.84000015258789),
                                      bottomRight:
                                          Radius.circular(12.84000015258789),
                                    ),
                                    color: Color.fromRGBO(41, 44, 53, 1),
                                  ))),
                          Positioned(
                              top: 22,
                              left: 25.74609375,
                              child: SizedBox(
                                  width: 214.25390625,
                                  height: 21,
                                  child: Stack(children: [
                                    const Positioned(
                                        top: 4,
                                        left: 40.25390625,
                                        child: Text('Enter your Phone Number',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Color.fromRGBO(194, 195, 203, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        )),
                                      Positioned(
                                        child: Image.asset("assets/images/_inputPhoneNumberIcon.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                  ]))),
                        ]),
                      ),
                    ),

                    // Welcome
                    const Positioned(
                        top: 20,
                        left: 70,
                        child: Text('Welcome to\nConnectX',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 38,
                              fontWeight: FontWeight.w500,
                              height: 1.2 *//*PERCENT not supported*//*
                              ),
                        )),
                  ]))),


          // Terms description txt
          const Positioned(
            top: 517,
            left: 100,
            child: Text('By clicking on Verification\nI agree to the\nConnectX Terms',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(102, 102, 102, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  height: 1.5 *//*PERCENT not supported*//*
                  ),
            ),
          ),
        ]));
  }*/
}
