import 'package:flutter/material.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';

import '../../../core/constants/global-variables/global-variables.dart';

class StoryCard extends StatefulWidget {
  const StoryCard({super.key});

  @override
  State<StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: (33 / deviceWidth) * deviceWidth,
          backgroundImage: const AssetImage(AssetImageConstants.storyCircle),
          child: CircleAvatar(
            radius: (29 / deviceWidth) * deviceWidth,
            backgroundImage: const AssetImage(AssetImageConstants.dummyImg),
          ),
        ),
        const Text("Name"),
      ],
    );
  }
}
