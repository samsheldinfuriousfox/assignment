import 'package:dyeus/src/utils/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();
  int currentTab = 0;
  TextEditingController phoneNumberController = TextEditingController();
  changeTab(int index) {
    if (isLoading) return;
    currentTab = index;
    update();
  }

  login() async {
    if (isLoading) return;

    _changeStatus(true, false, false);

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        Get.snackbar("Alert", "Error ${error.code}",
            backgroundColor: Colors.red);

        _changeStatus(false, false, true);
      },
      codeSent: (verificationId, forceResendingToken) {
        _changeStatus(false, true, false);

        Get.toNamed(RouteName.otp, parameters: {
          "number": "+91${phoneNumberController.text}",
          "verificationId": verificationId
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  check() {
    isLoading = true;
    update();
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
