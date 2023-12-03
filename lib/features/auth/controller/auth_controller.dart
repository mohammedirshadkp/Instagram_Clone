import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../Home-insta/screens/clone_homepage.dart';
import '../../Login-Signup/Screens/loginPage.dart';
import '../../Login-Signup/Screens/signUpPage.dart';

// getCurrentUserListen(String currentUserId) {
//   print(currentUserId);
//   FirebaseFirestore.instance
//       .collection(FirebaseConstants.userCollections)
//       .doc(currentUserId)
//       .snapshots()
//       .listen((event) {
//     if (event.data() != null) {
//       usersModel = UsersModel.fromJson(event.data()!);
//       print(usersModel!.userEmail);
//     }
//   });
// }

Future<UsersModel?> getUserData(String currentUserId) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection(FirebaseConstants.userCollections)
      .doc(currentUserId)
      .get();

  if (snapshot.exists) {
    final data = UsersModel.fromJson(snapshot.data()!);
    return data;
  } else {
    return null;
  }
}

class AuthController {
  final SignUpPage _signUpPage = const SignUpPage();
  final LoginPage _loginPage = const LoginPage();
  signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = result.user;
      currentUserId = user!.uid;
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (result.additionalUserInfo!.isNewUser) {
          var userData = UsersModel(
              userId: currentUserId,
              userEmail: googleUser!.email,
              userName: googleUser.displayName!,
              userPhoneNumber: "",
              userPassword: "",
              imageUrl: googleUser.photoUrl!,
              createDate: DateTime.now(),
              lastLogged: DateTime.now(),
              followersList: [],
              saved: []);
          FirebaseFirestore.instance
              .collection(FirebaseConstants.userCollections)
              .doc(value.user!.uid)
              .set(
                userData.toJson(),
              )
              .then((afterValue) async {
            var data = await FirebaseFirestore.instance
                .collection(FirebaseConstants.userCollections)
                .doc(currentUserId)
                .get();

            updateRef(currentUserId, data.reference);
          });
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.setBool("userLoggedIn", true);
          preferences.setString('userUid', user.uid);
        } else {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.setBool("userLoggedIn", true);
          preferences.setString('userUid', user.uid);
          updateUserLastLogged(currentUserId);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    } catch (e) {
      _signUpPage.errorMsg(context, e.toString());
    }
  }

  ///logout
  signOut(BuildContext context) {
    GoogleSignIn().signOut().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false));
  }

  ///Sign Up with email and password
  signUpWithEmailAndPass(
      {String? userEmail,
      String? userName,
      String? password,
      String? userPhoneNumber,
      String? imgUrl,
      BuildContext? context}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userEmail!, password: password!)
        .then(
      (value) {
        var userData = UsersModel(
            userEmail: userEmail,
            userName: userName!,
            userPhoneNumber: userPhoneNumber!,
            userPassword: password,
            imageUrl: "",
            createDate: DateTime.now(),
            lastLogged: DateTime.now(),
            userId: currentUserId,
            followersList: [],
            saved: []);
        FirebaseFirestore.instance
            .collection(FirebaseConstants.userCollections)
            .doc(value.user!.uid)
            .set(
              userData.toJson(),
            )
            .then((newValue) async {
          var data = await FirebaseFirestore.instance
              .collection(FirebaseConstants.userCollections)
              .doc(value.user!.uid)
              .get();
          updateRef(currentUserId, data.reference);
        });
        Navigator.push(
            context!,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
    ).onError((error, stackTrace) {
      _signUpPage.errorMsg(context!, error.toString());
    });
  }

  ///Login with email and password
  loginWithEmailAndPass(
      {required String userEmail,
      required String password,
      required BuildContext context}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: password)
        .then((value) {
      updateUserLastLogged(currentUserId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }).onError((error, stackTrace) {
      _loginPage.errorMsg(context: context, error: error.toString());
    });
  }

  ///Functions

  updateUserLastLogged(String currentUserId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("userLoggedIn", true);
    preferences.setString('userUid', currentUserId);
    // usersModel = (await getUserUpdate(currentUserId));
    usersModel = await getUserData(currentUserId);
    var updateData = usersModel?.copyWith(lastLogged: DateTime.now());
    FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .doc(currentUserId)
        .update(updateData!.toJson());
  }

  updateRef(String currentUserId, DocumentReference data) async {
    usersModel = await getUserData(currentUserId);
    // usersModel = (await getUserUpdate(currentUserId))!;
    var updateData = usersModel?.copyWith(ref: data);
    FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .doc(currentUserId)
        .update(updateData!.toJson());
  }
}
