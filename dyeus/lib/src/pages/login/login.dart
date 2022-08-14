import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:dyeus/src/components/common_button.dart';
import 'package:dyeus/src/components/svg_image.dart';
import 'package:dyeus/src/components/texts.dart';
import 'package:dyeus/src/pages/login/login_controller.dart';
import 'package:dyeus/src/utils/colors.dart';
import 'package:dyeus/src/utils/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: GetBuilder<LoginController>(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(35)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabText("Login", _.currentTab == 0, () {
                    _.changeTab(0);
                  }),
                  TabText("SignUp", _.currentTab == 1, () {
                    _.changeTab(1);
                  }),
                ],
              ),
            ),
            Expanded(
              child: ListView(padding: const EdgeInsets.all(20), children: [
                TitleText(
                  _.currentTab == 0 ? "Welcome back" : "Welcome to App ",
                ).marginSymmetric(vertical: 63),
                Text(_.currentTab == 0
                        ? "Please login with your phone number."
                        : "Please signup with your phone number to get registered")
                    .marginOnly(bottom: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(35)),
                  child: Row(children: [
                    CountryWidget(Country(
                        iso3Code: "IND",
                        isoCode: "IN",
                        name: "INDIA",
                        phoneCode: "+91")),
                    const SizedBox(width: 10),
                    Container(height: 15, width: 2, color: AppColors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none),
                      ),
                    ),
                  ]),
                ),
                CommonButton(
                  () {
                    _.login();
                  },
                  _.isLoading ? const CircularProgressIndicator() : "Continue",
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                ),
                const CustomDivider(),
                CommonButton(
                  () async {
                    String result = await SmsAutoFill().getAppSignature;
                    debugPrint(result);
                    Get.toNamed(RouteName.otp);
                  },
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SvgImage("metamask"),
                    Text(
                      " Connect to ",
                      style: Get.textTheme.subtitle2,
                    ),
                    Text("Metamask",
                        style: Get.textTheme.subtitle2
                            ?.copyWith(fontWeight: FontWeight.w800))
                  ]),
                  color: AppColors.green.withOpacity(0.3),
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                CommonButton(
                  () {},
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SvgImage("google"),
                    Text(
                      " Connect to ",
                      style: Get.textTheme.subtitle2,
                    ),
                    Text("Google",
                        style: Get.textTheme.subtitle2
                            ?.copyWith(fontWeight: FontWeight.w800))
                  ]),
                  color: AppColors.green.withOpacity(0.3),
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                CommonButton(
                  () {},
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SvgImage("apple"),
                    Text(
                      " Connect to ",
                      style: Get.textTheme.subtitle2
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "Apple",
                      style: Get.textTheme.subtitle2?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    )
                  ]),
                  color: Colors.black,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
                if (_.currentTab == 0)
                  Qtexts("Dont have an account?", "Signup", () {
                    _.changeTab(1);
                  })
              ]),
            ),
          ],
        );
      }),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
            height: 2,
            color: AppColors.grey,
          ),
        ),
        Text(
          "OR",
          style: Get.textTheme.subtitle1,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
            height: 2,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}

class CountryWidget extends StatelessWidget {
  final Country country;
  const CountryWidget(this.country, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text(country.phoneCode),
      ],
    );
  }
}

class TabText extends StatelessWidget {
  final String name;
  final bool isCurrent;
  final Function() onTap;
  const TabText(
    this.name,
    this.isCurrent,
    this.onTap, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          decoration: BoxDecoration(
              color: isCurrent ? AppColors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(35)),
          child: Text(name)),
    );
  }
}
