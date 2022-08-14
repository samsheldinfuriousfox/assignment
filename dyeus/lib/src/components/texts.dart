import 'package:dyeus/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Get.textTheme.headline3);
  }
}

class Qtexts extends StatelessWidget {
  final String question, text;
  final Function() onTap;
  const Qtexts(this.question, this.text, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: Get.textTheme.subtitle2,
        ),
        const SizedBox(width: 5),
        InkWell(
            onTap: onTap,
            child: Text(text,
                style: Get.textTheme.subtitle2?.copyWith(
                    color: AppColors.green, fontWeight: FontWeight.w600)))
      ],
    );
  }
}
