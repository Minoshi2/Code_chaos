import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class CustomDialogBox {

  static Future<dynamic> dialogBox(
    {
    required BuildContext context, 
    required DialogType dialogType, 
    required String title, 
    required String desc,
    }
  ) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }
}