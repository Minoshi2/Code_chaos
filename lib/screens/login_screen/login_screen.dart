import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drowsiness_app/components/custom_button.dart';
import 'package:drowsiness_app/components/custom_dialogbox.dart';
import 'package:drowsiness_app/components/custom_header.dart';
import 'package:drowsiness_app/components/custom_text.dart';
import 'package:drowsiness_app/components/custom_textfield.dart';
import 'package:drowsiness_app/controllers/auth_controller.dart';
import 'package:drowsiness_app/screens/home_screen/home_screen.dart';
import 'package:drowsiness_app/screens/register_screen/register_screen.dart';
import 'package:drowsiness_app/utils/app_color.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isObscure = true;
  final _email = TextEditingController();
  final _password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  
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
                HeaderSection(
                  size: size, image: 
                  'top.png', header: 
                  'Login', tagline: 
                  'Access Account',
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaButton(img: 'google.png',),
                        SizedBox(width: 15.0,),
                        SocialMediaButton(img: 'facebook.png'),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    CustomText(text: 'or Login with Email', fontWeight: FontWeight.w400,color: greyColor,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: 'Email', fontWeight: FontWeight.w500,),
                          SizedBox(height: 6.0,),
                          CustomTextField(controller: _email,),
                          SizedBox(height: 14.0,),
                          CustomText(text: 'Password', fontWeight: FontWeight.w500,),
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
                              text: 'Sign In', 
                              onTap: () async {
                                if(inputValidation()) {
                                  AuthController().loginUser(
                                    context, 
                                    _email.text,
                                    _password.text
                                  );
                                }else {
                                  CustomDialogBox.dialogBox(context: context, dialogType: DialogType.ERROR, title: 'Incorrect information', desc: 'Please enter correct information.');                 
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 15.0,),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      color: kblack,
                                      fontSize: 16.0,
                                    )
                                  ),
                                  TextSpan(
                                    text: " Register",
                                    style: TextStyle(
                                      color: kblack,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      UtillFunction.navigateTo(context, RegisterPage());
                                    }
                                  )
                                ]      
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
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
    if(_email.text.isEmpty || _password.text.isEmpty) {
      isValid = false;
    }else if(!EmailValidator.validate(_email.text)) {
      isValid = false;
    }else {
      isValid = true;
    }
    return isValid;
  }
}

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    required this.img,
    Key? key,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2.0,
        primary: kwhite,
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        )
      ),
      onPressed: () {}, 
      child: Image.asset(Constants.imageAsset(img))
    );
  }
}