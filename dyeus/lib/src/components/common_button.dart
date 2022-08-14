import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CommonButton extends StatelessWidget {
  final Function() onPressed;
  final dynamic child;
  final Color? color;
  final double? height, radius;
  final bool? gradient, shadow;
  final bool constraints;
  final BoxBorder? border;
  final TextStyle? childTextStyle;
  final EdgeInsets? margin, padding;
  const CommonButton(this.onPressed, this.child,
      {this.color,
      this.height,
      this.border,
      this.gradient,
      this.radius,
      this.margin,
      this.childTextStyle,
      this.padding,
      this.constraints = true,
      this.shadow,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: (MediaQuery.of(context).size.width >= 750 && constraints)
              ? MediaQuery.of(context).size.width * 0.5
              : double.infinity),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Container(
          margin: margin ?? const EdgeInsets.all(0),
          padding: padding ?? const EdgeInsets.all(0),
          //width: double.infinity,
          height: height ?? 48,
          decoration: BoxDecoration(
            color: color ?? AppColors.green,
            borderRadius: BorderRadius.circular(radius ?? 35),
            border: border,
            boxShadow: (shadow ?? false)
                ? [
                    BoxShadow(
                        offset: const Offset(0, 25),
                        blurRadius: 30.0,
                        color: Colors.black.withOpacity(0.25))
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: child is String
              ? Text(
                  child,
                  style: Get.textTheme.button,
                )
              : child,
          /* child: CommonButton(
            onPressed,
            child,
            color: Colors.transparent,
            height: 61,
          ), */
        ),
      ),
    );
  }
}
