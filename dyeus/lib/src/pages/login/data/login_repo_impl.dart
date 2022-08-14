import 'package:dartz/dartz.dart';
import 'package:dyeus/src/pages/login/domain/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginRepoImpl extends LoginRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<Either<String, String?>> login(String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {
          debugPrint("success");
          right("Success");
        },
        verificationFailed: (error) {
          debugPrint("error");
        },
        codeSent: (verificationId, forceResendingToken) {
          debugPrint("success");
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      return right("");
    } catch (e) {
      return left("Failure");
    }
  }
}
