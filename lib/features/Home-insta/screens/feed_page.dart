import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task1_app/core/constants/images/asset_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../repositories/home_repository.dart';
import '../widgets/single_post_container.dart';
import '../widgets/storyCard.dart';

class PostFeedPage extends StatefulWidget {
  const PostFeedPage({super.key});

  @override
  State<PostFeedPage> createState() => _PostFeedPageState();
}

class _PostFeedPageState extends State<PostFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.camera),
        ),
        title: SvgPicture.asset(AssetImageConstants.instagramLogoSvg),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.heart),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: deviceWidth,
            height: (98 / deviceHeight) * deviceHeight,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StoryCard(),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: HomeRepository.getFeedPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var posts = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: posts!.length,
                    itemBuilder: (context, index) {
                      return SinglePostContainer(post: posts[index]);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
