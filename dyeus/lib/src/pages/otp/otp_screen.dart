import 'package:dyeus/src/components/common_button.dart';
import 'package:dyeus/src/components/texts.dart';
import 'package:dyeus/src/pages/otp/otp_controller.dart';
import 'package:dyeus/src/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with CodeAutoFill {
  @override
  void initState() {
    listenToOtp();
    super.initState();
  }

  listenToOtp() async {
    listenForCode();
    await SmsAutoFill().getAppSignature;
  }

  @override
  void codeUpdated() {
    Get.find<OtpController>().otpChange(code);
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (() {
            Get.back();
          }),
        ),
      ),
      body: GetBuilder<OtpController>(builder: (_) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const TitleText("Enter OTP"),
          Text(
            "An five digit has been code sent to ${_.phoneNumber}",
            style: Get.textTheme.subtitle2,
          ).marginOnly(top: 24, bottom: 16),
          Row(
            children: [
              Qtexts("Incorrect number?", "Change", () {}),
            ],
          ),
          const SizedBox(height: 130),
          PinFieldAutoFill(
            currentCode: _.otp,
            decoration: UnderlineDecoration(
                colorBuilder: _.otp.isEmpty
                    ? const FixedColorBuilder(AppColors.grey)
                    : const FixedColorBuilder(Colors.black),
                textStyle: const TextStyle(
                    color: Colors
                        .black)), 
            onCodeChanged: (p0) {},
          ).marginSymmetric(horizontal: 20),
          if (_.otp.length != 6) ...[
            CommonButton(
              () {
                if (_.seconds != 0) return;
                _.resendOtp();
              },
              "Resend OTP",
              color: AppColors.green.withOpacity(_.seconds == 0 ? 1 : 0.3),
              margin: const EdgeInsets.only(bottom: 8, top: 60),
            ),
            if (_.seconds != 0)
              Text(
                "Resend OTP in ${_.seconds}s",
                style: Get.textTheme.subtitle2,
              ),
          ] else ...[
            _.isLoading
                ? Center(
                    child: const CircularProgressIndicator()
                        .marginOnly(bottom: 8, top: 60))
                : CommonButton(
                    () {
                      _.signIn();
                    },
                    "Done",
                    color:
                        AppColors.green.withOpacity(_.seconds == 0 ? 1 : 0.3),
                    margin: const EdgeInsets.only(bottom: 8, top: 60),
                  ),
            Center(
              child: Text(
                "Don’t you receive any code?",
                style: Get.textTheme.subtitle2,
              ).marginOnly(bottom: 10),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  _.resendOtp();
                },
                child: Text(
                  "Re-send Code",
                  style:
                      Get.textTheme.subtitle2?.copyWith(color: AppColors.green),
                ).marginOnly(bottom: 10),
              ),
            ),
          ]
        ]).marginAll(20);
      }),
    );
  }
}
