import 'package:drowsiness_app/screens/splash_screen/getting_started.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
   Future.delayed(const Duration(seconds: 5), () {
     UtillFunction.navigateTo(context, GettingStarted());
    }
   );
  } 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Constants.imageAsset('logo.png')),
          ],
        ),
      ),
    );
  }
}