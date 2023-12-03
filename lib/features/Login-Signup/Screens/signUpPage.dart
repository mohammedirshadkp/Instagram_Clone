import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';

import '../../../core/constants/global-variables/global-variables.dart';
import '../../auth/controller/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  void errorMsg(BuildContext context, String errorMsg) {
    final snackBar = SnackBar(content: Text(errorMsg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController _auth = AuthController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userPhoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userEmail = TextEditingController();
  bool _isVisible = false;
  bool _isConfirmVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Center(
                  child: Container(
                    width: deviceWidth * .9,
                    height: deviceHeight * .78,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(245, 245, 245, 1),
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Create an account",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: deviceHeight * .1,
                              width: deviceWidth * .85,
                              child: TextFormField(
                                validator: (userName) {
                                  if (userName == null) {
                                    return "Please  enter username";
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _userName,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _userName.clear();
                                      },
                                      icon: const Icon(
                                          FontAwesomeIcons.circleXmark)),
                                  suffixIconColor: Colors.black,
                                  label: const Text(
                                    "User name",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  prefixIconColor: Colors.black,
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.user,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * .1,
                              width: deviceWidth * .85,
                              child: TextFormField(
                                validator: (email) {
                                  if (email != null &&
                                      !EmailValidator.validate(email)) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
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
                                    icon: const Icon(
                                        FontAwesomeIcons.circleXmark),
                                  ),
                                  suffixIconColor: Colors.black,
                                  label: const Text(
                                    "Email Address",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  prefixIconColor: Colors.black,
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(FontAwesomeIcons.envelope),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * .1,
                              width: deviceWidth * .85,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _userPhoneNumber,
                                validator: (phoneNumber) {
                                  if (phoneNumber != null &&
                                      phoneNumber.length < 10) {
                                    return "Enter a valid phone No!";
                                  } else {
                                    return null;
                                  }
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  suffixIconColor: Colors.black,
                                  label: const Text(
                                    "Phone No",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  prefixIconColor: Colors.black,
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(FontAwesomeIcons.phone),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * .1,
                              width: deviceWidth * .85,
                              child: TextFormField(
                                controller: _password,
                                validator: (value) {
                                  if (value != null && value.length < 8) {
                                    return "Password must have 8 characters";
                                  } else {
                                    return null;
                                  }
                                },
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
                            SizedBox(
                              height: deviceHeight * .1,
                              width: deviceWidth * .85,
                              child: TextFormField(
                                validator: (confirmPassword) {
                                  if (confirmPassword != null &&
                                      confirmPassword != _password.text) {
                                    return "Passwords don't match!";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: _isConfirmVisible ? false : true,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isConfirmVisible
                                            ? _isConfirmVisible = false
                                            : _isConfirmVisible = true;
                                      });
                                    },
                                    icon: const Icon(FontAwesomeIcons.eye),
                                  ),
                                  suffixIconColor: Colors.black,
                                  label: const Text(
                                    "Confirm Password",
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
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            final isValidForm =
                                formKey.currentState!.validate();
                            if (isValidForm) {
                              _auth.signUpWithEmailAndPass(
                                  userEmail: _userEmail.text,
                                  userName: _userName.text,
                                  userPhoneNumber: _userPhoneNumber.text,
                                  password: _password.text,
                                  context: context);
                            }
                          },
                          child: Container(
                            height: deviceHeight * .07,
                            width: deviceWidth * .85,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(253, 132, 31, 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const Text("OR"),
                        GestureDetector(
                          onTap: () => _auth.signInWithGoogle(context),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
