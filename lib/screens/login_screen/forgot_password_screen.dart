import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drowsiness_app/components/custom_button.dart';
import 'package:drowsiness_app/components/custom_dialogbox.dart';
import 'package:drowsiness_app/components/custom_header.dart';
import 'package:drowsiness_app/components/custom_text.dart';
import 'package:drowsiness_app/components/custom_textfield.dart';
import 'package:drowsiness_app/controllers/auth_controller.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({ Key? key }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = UtillFunction.mediaQuery(context);
    return Scaffold(
      body: Container(
        height: size.height,
        color: const Color(0xffE5E5E5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                size: size, 
                image: 'top.png', 
                header: 'Forgot Password',
                tagline: 'Reset your password',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, 
                  vertical: 30.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Email',
                      fontSize: 20.0,
                    ),
                    SizedBox(height: 20.0,),
                    CustomTextField(controller: _email),
                    SizedBox(height: 30.0,),
                    CustomButton(
                      text: 'Send password reset email', 
                      onTap: () async {
                        if (inputValidation()) {
                          await AuthController().sendPasswordResetEmail(context, _email.text);
                        }
                        else {
                          CustomDialogBox.dialogBox(
                            context: context, 
                            dialogType: DialogType.ERROR, 
                            title: 'Incorrect information', 
                            desc: 'Please enter correct information.'
                          );
                        }
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool inputValidation() {
    var isValid = false;
    if(_email.text.isEmpty) {
      isValid = false;
    }else if(!EmailValidator.validate(_email.text)) {
      isValid = false;
    }else {
      isValid = true;
    }
    return isValid;
  }
}