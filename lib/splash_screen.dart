import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';
import 'Models/userModel.dart';
import 'core/constants/Firebase/firebase_constants.dart';
import 'core/constants/global-variables/global-variables.dart';
import 'features/Home-insta/screens/clone_homepage.dart';
import 'features/Login-Signup/Screens/loginPage.dart';
import 'features/auth/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogged = false;
  isUserLoggedIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool("userLoggedIn") != null) {
      setState(() {
        isLogged = preferences.getBool("userLoggedIn")!;
        currentUserId = preferences.getString("userUid")!;
      });
      print(
          "==========================================================$currentUserId");
      usersModel = await getUserData(currentUserId);
      var updateData = usersModel!.copyWith(lastLogged: DateTime.now());
      FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollections)
          .doc(currentUserId)
          .update(updateData.toJson());
    }
  }

  navigateToPage() {
    Timer(const Duration(seconds: 3), () {
      isLogged
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);
    });
  }

  @override
  void initState() {
    isUserLoggedIn();
    navigateToPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    double appBarHeightScale = deviceHeight / 88;
    appBarHeight = deviceHeight * appBarHeightScale;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: deviceHeight * .95,
            width: deviceWidth,
            child: const Center(
              child: Image(
                image: AssetImage(AssetImageConstants.splashScreenGif),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
