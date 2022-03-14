import 'package:drowsiness_app/screens/home_screen/home_screen.dart';
import 'package:drowsiness_app/screens/login_screen/login_screen.dart';
import 'package:drowsiness_app/screens/register_screen/register_screen.dart';
import 'package:drowsiness_app/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drowsiness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

