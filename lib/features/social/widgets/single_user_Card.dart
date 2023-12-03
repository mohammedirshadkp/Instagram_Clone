import 'package:flutter/material.dart';
import 'package:task1_app/features/social/repositories/social_repositories.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../auth/controller/auth_controller.dart';

class SingleUserCard extends StatefulWidget {
  final UsersModel user;
  final int inx;
  final List? followList;
  const SingleUserCard(
      {super.key,
      required this.user,
      required this.inx,
      required this.followList});

  @override
  State<SingleUserCard> createState() => _SingleUserCardState();
}

class _SingleUserCardState extends State<SingleUserCard> {
  UsersModel? user;
  int? inx;
  List? followList;
  bool isFollowed = false;

  followUnFollow() {
    setState(() {
      followList!.contains(currentUserId)
          ? followList!.remove(currentUserId)
          : followList!.add(currentUserId);
      isFollowed == false ? isFollowed = true : isFollowed = false;
    });
    SocialRepositories.addFollowUnFollowToFirebase(
        user: user!, followList: followList!);
  }

  checkIsFollowedInitState() {
    setState(() {
      if (user!.followersList.contains(currentUserId)) {
        isFollowed = true;
      } else {
        isFollowed = false;
      }
    });
  }

  @override
  void initState() {
    user = widget.user;
    inx = widget.inx;
    followList = widget.followList;

    checkIsFollowedInitState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${inx! + 1}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user!.imageUrl.toString()),
            ),
          ],
        ),
        title: Text(user!.userName.toString()),
        subtitle: Text(user!.userEmail.toString()),
        trailing: TextButton(
            onPressed: () {
              followUnFollow();
            },
            child: Text(isFollowed ? "Unfollow" : "Follow")),
      ),
    );
  }
}
