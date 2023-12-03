import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/Color/pallete.dart';

class TabBarProfilePage extends StatefulWidget {
  const TabBarProfilePage({super.key});

  @override
  State<TabBarProfilePage> createState() => _TabBarProfilePageState();
}

class _TabBarProfilePageState extends State<TabBarProfilePage> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Pallete.secondaryColor,
      tabs: [
        const Icon(
          Icons.grid_on,
          color: Pallete.secondaryColor,
          size: 30,
        ),
        SvgPicture.asset("images/Tags Tap.svg"),
      ],
    );
  }
}
