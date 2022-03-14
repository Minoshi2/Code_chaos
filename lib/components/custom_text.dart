import 'package:drowsiness_app/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({ 
    Key? key, 
    required this.text,
    this.fontSize = 16.0,
    this.color = kblack,
    this.fontWeight,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}