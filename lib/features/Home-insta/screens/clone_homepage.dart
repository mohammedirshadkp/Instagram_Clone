import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/coming%20soon.dart';
import 'package:task1_app/features/post/screens/createPostPage.dart';
import 'package:task1_app/features/profile/screens/profilePage.dart';
import 'package:task1_app/features/social/screens/users_list.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import 'feed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _pages = [
    const PostFeedPage(),
    const UsersList(),
    const CreatePostPage(),
    const CommingSoonPage(),
    ProfilePage(
      user: usersModel!,
    ),
  ];

  int _selectedIndex = 0;
  _onItemTapped(int currentIndex) {
    setState(() {
      _selectedIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              size: 30,
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.search,
                size: 30,
              ),
              label: ""),
          const BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add,
                size: 30,
              ),
              label: ""),
          const BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.heart,
                size: 30,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: CachedNetworkImage(
                imageUrl: usersModel!.imageUrl,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: (15 / deviceHeight) * deviceHeight,
                ),
              ),
              label: ""),
        ],
      ),
    );
  }
}
