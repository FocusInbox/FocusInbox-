/*

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/fi_display.dart';
import '../../utils/fi_resources.dart';
import '../base/fi_base_state.dart';
import '../base/fi_base_widget.dart';
import '../utils/cx_ui_elements.dart';
import 'cx_registration_model.dart';

class CxVerificationWidget extends FiBaseWidget {
  const CxVerificationWidget({super.key});

  @override
  Future<bool> get onWillPop {
    registrationModel.onRegistrationBack();
    return Future.value(false);
  }

  @override
  State<StatefulWidget> createState() => _CxVerificationWidgetState();
}

class _CxVerificationWidgetState extends FiBaseState<CxVerificationWidget> {
  @override
  void initState() {
    super.initState();
    registrationModel.setState(this);
    registrationModel.startResendAllowTimer();
  }

  @override
  void dispose() {
    super.dispose();
    registrationModel.stopVerifySmsCode();
    registrationModel.verificationSmsCodeController.dispose();
  }

  @override
  @protected
  Widget get content => Stack(
        children: [
          Positioned(
              top: toY(162),
              left: centerOnDisplayByWidth(toX(350)),
              width: toX(350),
              height: toY(502),
              child: Container(
                width: toX(350),
                height: toY(502),
                decoration: ShapeDecoration(
                  color: const Color(0xFF141416),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0C241F2F),
                      blurRadius: 55.48,
                      offset: Offset(0, 13.32),
                      spreadRadius: 0,
                    )
                  ],
                ),
              )),
          Positioned(
              top: toY(202),

              width: display.width,
              height: toX(28),
              child: Center(child: Text(
                localise("verify_phone_number"),
                style: TextStyle(
                  color: const Color(0xFFF9F8FF),
                  fontSize: toY(22),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.88,
                ),
              ))),
          Positioned(
              top: toY(241),
              width: display.width,
              height: toX(21),
              child:  Center(child: Text(
                localise("we_sent_code"),
                style: TextStyle(
                  color: const Color(0xFFACADB9),
                  fontSize: toY(14),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ))),
          Positioned(
              top: toY(301),
              left: centerOnDisplayByWidth(toX(130)),
              width: toX(130),
              height: toX(23),
              child: Text(
                registrationModel.userPhone ?? "",
                style:  TextStyle(
                  color: const Color(0xFFACADB9),
                  fontSize: toY(15),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.30,
                ),
              )),
          Positioned(
              top: toY(433),
              left: toX(60),
              width: toX(53),
              height: toX(22),
              child: Text(
                registrationModel.resendTimerValue,
                style:  TextStyle(
                  color: const Color(0xFFACADB9),
                  fontSize: toY(14.39),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.29,
                ),
              )),
          Positioned(left: centerOnDisplayByWidth(toX(300)), top: toY(473), width: toX(300), height: toY(66), child: uiElements.button(localise("verify"), registrationModel.onSendVerificationCode, enabled: registrationModel.sendVerificationIsAllowed, progressVisible: registrationModel.verificationInProgress)),
          Positioned(left: centerOnDisplayByWidth(toX(300)), top: toY(551), width: toX(300), height: toY(66), child: uiElements.button(localise("send_again"), registrationModel.onResendCode, enabled: registrationModel.resendCodeAllowed, progressVisible: registrationModel.resendCodeInProgress)),
          Positioned(
              top: toY(353),
              left: centerOnDisplayByWidth(display.width - toX(60)),
              width: display.width - toX(60),
              height: toX(60),
              child: CxPinCodeFields(
                  length: 4,
                  //controller: registrationModel.verificationSmsCodeController,
                  keyboardType: TextInputType.number,
                  fieldBorderStyle: CxFieldBorderStyle.square,
                  responsive: false,
                  borderColor: const Color(0xFFC2C3CB),
                  fieldHeight: toX(60),
                  fieldWidth: toX(60),
                  digits: registrationModel.digits,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: toY(41.86),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    letterSpacing: -0.84,
                  ),
                  borderRadius: BorderRadius.circular(13),
                  obscureText: false,
                  onComplete: registrationModel.onInputVerificationModeComplete,
                 ))
        ],
      );
}
*/
