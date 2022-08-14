import 'dart:async';

import 'package:dyeus/src/utils/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpController extends GetxController {
  late String phoneNumber;
  late String verificationId;
  @override
  void onInit() {
    phoneNumber = Get.parameters["number"] ?? "";
    verificationId = Get.parameters["verificationId"] ?? "";
    otpTimer();
    //  listenToOtp();
    super.onInit();
  }

  @override
  onClose() {
    SmsAutoFill().unregisterListener();
    super.onClose();
  }

  String otp = "";
  otpChange(String? otpvalue) {
    debugPrint(otpvalue);
    otp = otpvalue ?? "";
  }

  int seconds = 30;
  otpTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) return;
      seconds--;
      update();
    });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void signIn() async {
    if (isLoading) return;

    _changeStatus(true, false, false);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    firebaseAuth.signInWithCredential(credential).catchError((error) {
      Get.snackbar("Alert", "Error ${error.code}", backgroundColor: Colors.red);

      _changeStatus(false, false, true);
    }).then((UserCredential user) async {
      _changeStatus(false, true, false);
      Get.toNamed(RouteName.home);
    });
  }

  resendOtp() async {
    Get.snackbar("Alert", "Sending Request", backgroundColor: Colors.green);

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        Get.snackbar("Alert", "Error ${error.code}",
            backgroundColor: Colors.red);
      },
      codeSent: (verificationId, forceResendingToken) {
        Get.snackbar("Alert", "Code resend}", backgroundColor: Colors.green);
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  bool isLoading = false;
  bool isLoaded = false;
  bool isError = false;
  _changeStatus(bool loading, bool loaded, bool error) {
    isLoading = loading;
    isLoaded = loaded;
    isError = error;
    update();
  }
}
