import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/features/saved/repositories/saved_repositories.dart';

import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/global-variables/global-variables.dart';

class SingleSavedPost extends StatefulWidget {
  final MediaModel savedPost;
  final Function callBackFunction;
  const SingleSavedPost(
      {super.key, required this.savedPost, required this.callBackFunction});

  @override
  State<SingleSavedPost> createState() => _SingleSavedPostState();
}

class _SingleSavedPostState extends State<SingleSavedPost> {
  MediaModel? savedPost;
  @override
  void initState() {
    savedPost = widget.savedPost;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Wrap(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            savedPost!.userName.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * .5,
                        width: deviceWidth * .8,
                        child: CachedNetworkImage(
                          imageUrl: savedPost!.postUrl.toString(),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${savedPost!.userName} : ${savedPost!.postDescription}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: const Color.fromRGBO(183, 4, 4, 1),
                            elevation: 0,
                            onPressed: () {
                              SavedRepositories.unSavePost(
                                  savedPost: savedPost!,
                                  context: context,
                                  callBackFunction: widget.callBackFunction);
                            },
                            label: const Text("Unsave post"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        color: Colors.white,
        child: CachedNetworkImage(
          imageUrl: savedPost!.postUrl.toString(),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
