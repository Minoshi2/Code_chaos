import 'package:drowsiness_app/utils/app_color.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    Key? key,
    required this.size,
    required this.image,
    this.header,
    this.tagline,
    this.widget,
    
  }) : super(key: key);

  final size;
  final String image;
  final String? header;
  final String? tagline;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          Constants.imageAsset(image),
          width: size.width,
          fit: BoxFit.fitWidth,
        ),
        widget == null ?Center(
          child: Column(
            children: [
              SizedBox(height: 59.0,),
              Text(
                header ?? "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: kblack
                )
              ),
              Text(
                tagline ?? "",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: kblack
                )
              ),
            ],
          ),
        ): widget !,
      ],
    );
  }
}