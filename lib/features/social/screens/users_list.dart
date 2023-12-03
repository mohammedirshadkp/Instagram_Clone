import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task1_app/features/profile/screens/profilePage.dart';
import 'package:task1_app/features/social/widgets/single_user_Card.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  bool iconVisibility = false;
  TextEditingController _search = TextEditingController();
  List<UsersModel> users = [];
  List<UsersModel> users1 = [];
  onSearch(String text) {
    users.clear();
    if (text == '') {
      users.addAll(users1);
      setState(() {});
      return;
    }
    for (var details in users1) {
      if (details.userName.toLowerCase().indexOf(text.toLowerCase()) == 0 ||
          details.userName.contains(text.toLowerCase())) {
        users.add(details);
      }
    }
    setState(() {});
  }

  StreamSubscription? user;
  //TODO getUser Function setState
  getUsers() async {
    user = FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        users.clear();
        users1.clear();
        for (var a in event.docs) {
          if (UsersModel.fromJson(a.data()).userId != currentUserId) {
            users.add(UsersModel.fromJson(a.data()));
            users1.add(UsersModel.fromJson(a.data()));
          }
        }
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    user!.cancel();
    _search.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    getUsers();
    _search = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return usersModel == null
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: _search,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIconColor: Colors.black,
                      prefixIconColor: Colors.black,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: iconVisibility
                          ? IconButton(
                              icon: const Icon(FontAwesomeIcons.circleXmark),
                              onPressed: () {
                                _search.clear();
                                users.clear();
                                users.addAll(users1);
                                setState(() {
                                  iconVisibility = false;
                                });
                              },
                            )
                          : null,
                      hintText: "Search here",
                    ),
                    onChanged: (value) {
                      onSearch(value);
                      setState(() {
                        if (_search.text.isNotEmpty) {
                          iconVisibility = true;
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      UsersModel user = users[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(user: user),
                              ));
                        },
                        child: SingleUserCard(
                          inx: index,
                          user: user,
                          followList: user.followersList,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
