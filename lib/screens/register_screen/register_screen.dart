import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drowsiness_app/components/custom_button.dart';
import 'package:drowsiness_app/components/custom_dialogbox.dart';
import 'package:drowsiness_app/components/custom_header.dart';
import 'package:drowsiness_app/components/custom_textfield.dart';
import 'package:drowsiness_app/controllers/auth_controller.dart';
import 'package:drowsiness_app/utils/app_color.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _isObscure = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = UtillFunction.mediaQuery(context);
    return Scaffold(
      body: FadeInRight(
        child: Container(
          height: size.height,
          color: const Color(0xffE5E5E5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderSection(size: size, image: 'top.png', header: 'Register', tagline: 'Create Account',),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: kblack,
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      CustomTextField(controller: _name,),
                      SizedBox(height: 14.0,),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: kblack,
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      CustomTextField(controller: _email,),
                      SizedBox(height: 14.0,),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: kblack,
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      CustomTextField(controller: _phone,),
                      SizedBox(height: 14.0,),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: kblack,
                        ),
                      ),
                      SizedBox(height: 6.0,),
                      SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: _password,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: kwhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure =! _isObscure;
                                });
                              }, 
                              icon: Icon(_isObscure 
                              ? Icons.visibility
                              : Icons.visibility_off,
                              )
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 35.0,),
                      Center(
                        child: CustomButton(
                          text: 'Register', 
                           onTap: () async {
                            if(inputValidation()) {
                              await AuthController().registerUser(context, _email.text, _password.text, _name.text, _phone.text);
                            }else {   
                              CustomDialogBox.dialogBox(context: context, dialogType: DialogType.ERROR, title: 'Incorrect information', desc: 'Please enter correct information.');                      }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool inputValidation() {
    var isValid = false;
    if(
      _email.text.isEmpty ||
      _name.text.isEmpty || 
      _phone.text.isEmpty || 
      _password.text.isEmpty) {
        isValid = false;
    }else if(!EmailValidator.validate(_email.text)) {
      isValid = false;
    }else if(_phone.text.length != 10) {
      isValid = false;
    }
    else {
      isValid = true;
    }
    return isValid;
  }
}
