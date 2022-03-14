import 'package:flutter/material.dart';

class UtillFunction{

  //Navigation to page
  static navigateTo(BuildContext context, Widget widget) {
    return Navigator.push(context, 
      MaterialPageRoute(builder: (context) => widget));
  }

  //
  static mediaQuery(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}