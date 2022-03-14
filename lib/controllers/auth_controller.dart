import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drowsiness_app/components/custom_dialogbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthController {
  //Firebase auth instance created
  FirebaseAuth auth = FirebaseAuth.instance;

  // User registration function
  Future<void> registerUser(BuildContext context, String email, String password) async {
    
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
      CustomDialogBox.dialogBox(
          context, DialogType.SUCCES, 
          'User Account Created.', 
          'Congratulation, Now you can log in.'
        );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialogBox.dialogBox(
          context, DialogType.ERROR, 
          'The password provided is too weak.', 
          'PLease enter valid password'
        );
      } else if (e.code == 'email-already-in-use') {
        CustomDialogBox.dialogBox(
          context, DialogType.ERROR, 
          'The account already exists for that email.', 
          'Please enter valid email'
        );
      }
    } catch (e) {
      print(e);
    }
  }
  //User login function
  Future<void> loginUser() async {
    
  }
}