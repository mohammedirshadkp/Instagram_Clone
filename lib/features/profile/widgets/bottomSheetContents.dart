import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1_app/features/saved/screens/saved_page.dart';

import '../../../core/constants/global-variables/global-variables.dart';
import '../../social/screens/users_list.dart';
import '../../Login-Signup/Screens/loginPage.dart';
import '../screens/editProfile.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileEditPage(),
                ));
          },
          child: const ListTile(
            leading: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const UsersList(),
                ));
          },
          child: const ListTile(
            leading: Icon(
              FontAwesomeIcons.users,
              color: Colors.black,
            ),
            title: Text("All users", style: TextStyle(color: Colors.black)),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedPage(),
                ));
          },
          child: const ListTile(
            leading: Icon(
              FontAwesomeIcons.bookmark,
              color: Colors.black,
            ),
            title: Text("Saved", style: TextStyle(color: Colors.black)),
          ),
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  isDarkMode ? isDarkMode = false : isDarkMode = true;
                });
              },
              child: isDarkMode
                  ? const ListTile(
                      leading: Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Switch to light mode",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : const ListTile(
                      leading: Icon(
                        Icons.dark_mode,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Switch to dark mode",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            _googleSignIn.signOut().then((value) async {
              final SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove("userLoggedIn");
              preferences.remove("userUid");
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          },
          child: const ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
