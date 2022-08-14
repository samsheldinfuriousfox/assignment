import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? height, width;

  const SvgImage(this.asset, {this.color, this.height, this.width, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/$asset.svg",
      color: color,
      alignment: Alignment.center,
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}