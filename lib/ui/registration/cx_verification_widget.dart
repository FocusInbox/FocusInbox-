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
    registrationModel.stopVerifyCode();
    //registrationModel.verificationSmsCodeController.dispose();
  }

  @override
  @protected
  Widget get content => Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: toY(277),
              left: 0,
              right: 0,
              child: Center(
                child: Text(localise("whatsapp"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: toY(30),
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
              )),
          Positioned(
              top: toY(311),
              left: 0,
              right: 0,
              child: Center(
                child: Text(localise("authentication_process"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: toY(25),
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
              )),
          Positioned(
            top: toY(394.5), // Y position as specified
            child: SizedBox(
              height: toY(85), // Adjusted height
              width: toX(85), // Adjusted width
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1.0, // Full circle background
                    strokeWidth: 5,
                    backgroundColor: Color(0xFF0677E8),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFA4C6E8)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: toY(528),
              left: 0,
              right: 0,
              child: Text(
                localise("we_sent_qr"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color.fromRGBO(0x94, 0x94, 0x94, 1.0),
                    fontSize: toY(18),
                    //  fontWeight: FontWeight.bold,
                    height: 1.5),
              )),
          /* Positioned(
              top: toY(301),
              left: centerOnDisplayByWidth(toX(130)),
              width: toX(130),
              height: toX(23),
              child: Text(
                registrationModel.mailAddress ?? "",
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
                 ))*/
        ],
      );
}
