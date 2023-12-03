import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';
import 'package:task1_app/features/profile/repositories/profile_repositories.dart';

import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';

class FollowingPage extends StatefulWidget {
  final Function callBackFunction;
  final int followingLength;
  final UsersModel user;
  const FollowingPage(
      {super.key,
      required this.callBackFunction,
      required this.followingLength,
      required this.user});
  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  UsersModel? user;
  int? followingLength;

  unFollowFunction({required UsersModel followingUser}) {
    setState(() {
      followingUser.followersList.remove(currentUserId);
    });
    ProfileRepositories.updateFollowingToFirebase(followingUser);
    widget.callBackFunction(followingLength);
  }

  @override
  void initState() {
    user = widget.user;
    followingLength = widget.followingLength;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ProfileRepositories.getFollowingStream(user!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var following = snapshot.data;
            return following!.isEmpty
                ? Container(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Image(
                            image:
                                AssetImage(AssetImageConstants.noFollowingImg),
                          ),
                        ),
                        user!.userId == currentUserId
                            ? const Text(
                                "You are not following anyone!🗿",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            : Text(
                                "${user!.userName} are not following anyone!🗿",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: following.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                following[index].imageUrl.toString()),
                          ),
                          title: Text(
                            following[index].userName.toString(),
                          ),
                          subtitle: Text(following[index].userEmail.toString()),
                          trailing: user!.userId == currentUserId
                              ? TextButton(
                                  onPressed: () {
                                    unFollowFunction(
                                        followingUser: following[index]);
                                  },
                                  child: const Text("Unfollow"))
                              : null,
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
