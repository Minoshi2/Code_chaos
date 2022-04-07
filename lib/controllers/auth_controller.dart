import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drowsiness_app/components/custom_dialogbox.dart';
import 'package:drowsiness_app/controllers/db_controller.dart';
import 'package:drowsiness_app/screens/home_screen/home_screen.dart';
import 'package:drowsiness_app/screens/login_screen/login_screen.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthController {
  //Firebase auth instance created
  FirebaseAuth auth = FirebaseAuth.instance;

  // User registration function
  Future<void> registerUser(
    BuildContext context, 
    String email, 
    String password,
    String name,
    String phone,
  ) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      if (userCredential.user!.uid.isNotEmpty) {
        await DataBaseController().saveUserData(
            name, phone, email, userCredential.user!.uid);
      }
      CustomDialogBox.dialogBox(
          context: context, 
          dialogType: DialogType.SUCCES, 
          title: 'User Account Created.', 
          desc: 'Congratulation, Now you can log in.'
        );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialogBox.dialogBox(
          context: context, 
          dialogType: DialogType.ERROR, 
          title: 'The password provided is too weak.', 
          desc: 'PLease enter valid password'
        );
      } else if (e.code == 'email-already-in-use') {
        CustomDialogBox.dialogBox(
          context: context, 
          dialogType: DialogType.ERROR, 
          title: 'The account already exists for that email.', 
          desc: 'Please enter valid email'
        );
      }
    } catch (e) {
      print(e);
    }
  }
  //User login function
  Future<void> loginUser(BuildContext context, String email, String password) async {
      try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user != null) {
        UtillFunction.navigateTo(context, const HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialogBox.dialogBox(
          context: context, 
          dialogType: DialogType.ERROR, 
          title: 'No user found for that email.', 
          desc: 'Please enter valid email.'
        );                 
      } else if (e.code == 'wrong-password') {
        CustomDialogBox.dialogBox(
          context: context, 
          dialogType: DialogType.ERROR, 
          title: 'Wrong password provided for that user.', 
          desc: 'Please enter valid password.'
        );               
      }
    }
  }
}