import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';
import 'package:task1_app/features/Login-Signup/Screens/signUpPage.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../auth/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  void errorMsg({required BuildContext context, String? error}) {
    final snackBar = SnackBar(
      content: Text(
        '$error',
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: (Colors.white70),
      action: SnackBarAction(label: "OK", onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  final AuthController _auth = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Container(
                width: deviceWidth,
                height: deviceHeight * .50,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Login using email address",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: deviceHeight * .1,
                          width: deviceWidth * .9,
                          child: TextFormField(
                            validator: (value) {
                              return null;
                            },
                            controller: _userEmail,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _userEmail.clear();
                                },
                                icon: const Icon(FontAwesomeIcons.circleXmark),
                              ),
                              suffixIconColor: Colors.black,
                              label: const Text(
                                "Email Address",
                                style: TextStyle(color: Colors.grey),
                              ),
                              prefixIconColor: Colors.black,
                              prefixIcon: const Icon(FontAwesomeIcons.envelope),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * .1,
                          width: deviceWidth * .9,
                          child: TextFormField(
                            controller: _password,
                            obscureText: _isVisible ? false : true,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isVisible
                                        ? _isVisible = false
                                        : _isVisible = true;
                                  });
                                },
                                icon: const Icon(FontAwesomeIcons.eye),
                              ),
                              suffixIconColor: Colors.black,
                              label: const Text(
                                "Password",
                                style: TextStyle(color: Colors.grey),
                              ),
                              prefixIconColor: Colors.black,
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(FontAwesomeIcons.lock),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 132, 31, 1)),
                              ),
                            ),
                          ],
                        ),
                        const Text("OR"),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            _auth.signInWithGoogle(context);
                          },
                          child: Container(
                            width: deviceWidth * .5,
                            height: deviceHeight * .05,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 234, 211, 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      AssetImageConstants.googleLogo),
                                ),
                                Text("Continue with Google"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _auth.signUpWithEmailAndPass();
                      },
                      child: Container(
                        height: deviceHeight * .07,
                        width: deviceWidth * .9,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 132, 31, 1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
