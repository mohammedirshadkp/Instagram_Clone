import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/core/constants/Color/pallete.dart';
import 'package:task1_app/splash_screen.dart';
import 'core/constants/global-variables/global-variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyA0-12xvs8tT2IMwRsGkPqoUCRwfaEHoBg",
  //         appId: "1:147360322694:web:fae7b83b51db83e6e4ed07",
  //         messagingSenderId: "147360322694",
  //         projectId: "dried-fruits-and-nuts"),
  //   ).whenComplete(() => print("Completed"));
  // } else {
  //   await Firebase.initializeApp().whenComplete(() => print("Completed"));
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? Pallete.darkModeAppTheme : Pallete.lightModeAppTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
