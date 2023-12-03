import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task1_app/core/constants/Color/pallete.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';
import 'package:task1_app/features/auth/controller/auth_controller.dart';
import 'package:task1_app/features/profile/screens/editProfile.dart';
import 'package:task1_app/features/profile/widgets/bottomSheetContents.dart';
import '../../../Models/userModel.dart';
import '../../../coming soon.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../widgets/tabBar.dart';
import 'Myposts_page.dart';
import 'folllowing_page.dart';
import 'followersPage.dart';

class ProfilePage extends StatefulWidget {
  final UsersModel user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UsersModel? user;

  int followingLength = 0;

  //TODO getFollowing length setState
  getFollowingLength() async {
    var query = FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .where('followers', arrayContains: user!.userId);
    AggregateQuerySnapshot queryLength = await query.count().get();
    followingLength = queryLength.count;
    if (mounted) {
      setState(() {});
    }
  }

  callBackFunction(int len) {
    setState(() {
      followingLength = len - 1;
    });
  }

  showDialogFunction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Center(
          child: Image(
            image: NetworkImage(user!.imageUrl.toString()),
            fit: BoxFit.fill,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    user = widget.user;
    getFollowingLength();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          actions: [
            user!.userId == currentUserId
                ? IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        context: context,
                        builder: (context) {
                          return const BottomSheetPage();
                        },
                      );
                    },
                    icon: const Icon(Icons.menu),
                  )
                : const SizedBox(),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user!.userName.toString()),
              const SizedBox(
                width: 2,
              ),
              const Icon(
                FontAwesomeIcons.angleDown,
                size: 15,
              ),
            ],
          )),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              width: deviceWidth,
              height: (300 / deviceHeight) * deviceHeight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CachedNetworkImage(
                        imageUrl: user!.imageUrl,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: (46 / deviceWidth) * deviceWidth,
                          backgroundImage:
                              const AssetImage(AssetImageConstants.storyCircle),
                          child: GestureDetector(
                            onTap: () {
                              showDialogFunction();
                            },
                            child: CircleAvatar(
                              backgroundImage: imageProvider,
                              radius: (43 / deviceWidth) * deviceWidth,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: (205 / deviceWidth) * deviceWidth,
                        height: (36 / deviceHeight) * deviceHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text("Posts"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FollowersPage(
                                      user: user!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    user!.followersList.length.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const Text("Followers"),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FollowingPage(
                                      callBackFunction: callBackFunction,
                                      followingLength: followingLength,
                                      user: user!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    followingLength.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const Text("Following"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        user!.userName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(user!.userEmail),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(user!.userPhoneNumber),
                    ],
                  ),
                  user!.userId == currentUserId
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileEditPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: (343 / deviceWidth) * deviceWidth,
                            height: (29 / deviceHeight) * deviceHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey)),
                            child: const Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100.0),
                    child: SizedBox(
                      width: (310 / deviceWidth) * deviceWidth,
                      height: (83 / deviceHeight) * deviceHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: (64 / deviceWidth) * deviceWidth,
                            height: (83 / deviceHeight) * deviceHeight,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: (33 / deviceWidth) * deviceWidth,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: Pallete.primaryColor,
                                    radius: (32 / deviceWidth) * deviceWidth,
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                                const Text("New"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: (64 / deviceWidth) * deviceWidth,
                            height: (83 / deviceHeight) * deviceHeight,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: (33 / deviceWidth) * deviceWidth,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: Pallete.primaryColor,
                                    radius: (32 / deviceWidth) * deviceWidth,
                                    backgroundImage: const AssetImage(
                                        AssetImageConstants.dummyImg),
                                  ),
                                ),
                                const Text("post1"),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: (64 / deviceWidth) * deviceWidth,
                            height: (83 / deviceHeight) * deviceHeight,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: (33 / deviceWidth) * deviceWidth,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    backgroundColor: Pallete.primaryColor,
                                    radius: (32 / deviceWidth) * deviceWidth,
                                    backgroundImage: const AssetImage(
                                        AssetImageConstants.dummyImg),
                                  ),
                                ),
                                const Text("post2"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const TabBarProfilePage(),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserPostPage(
                    user: user!,
                  ),
                  const CommingSoonPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
