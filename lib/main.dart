import 'package:camera/camera.dart';
import 'package:drowsiness_app/screens/camera_screen/camera_screen.dart';
import 'package:drowsiness_app/screens/home_screen/home_screen.dart';
import 'package:drowsiness_app/screens/splash_screen/splash_screen.dart';
import 'package:drowsiness_app/screens/tracking_screen/tracking_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? camera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  camera = await availableCameras();
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
      home: const TrackingScreen(),
    );
  }
}

