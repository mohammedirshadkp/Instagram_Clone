import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/features/profile/repositories/profile_repositories.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';

class FollowersPage extends StatefulWidget {
  final UsersModel user;
  const FollowersPage({super.key, required this.user});
  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<UsersModel> followersList = [];
  UsersModel? user;

  getFollowers() async {
    followersList = await ProfileRepositories.getFollowers(
        user: user!, followersList: followersList);
  }

  @override
  void initState() {
    user = widget.user;
    followersList = getFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: followersList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: user!.followersList.length,
              itemBuilder: (context, index) {
                var follower = followersList[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(follower.imageUrl.toString()),
                    ),
                    title: Text(follower.userName.toString()),
                    subtitle: Text(follower.userEmail.toString()),
                  ),
                );
              },
            ),
    );
  }
}
