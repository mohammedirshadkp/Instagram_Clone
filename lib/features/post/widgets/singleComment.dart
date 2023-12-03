import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task1_app/features/post/repositories/post_repository.dart';
import '../../../Models/commentModel.dart';
import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';

class SingleComment extends StatefulWidget {
  final CommentModel postComment;
  final MediaModel post;
  final Function callBackFunction;
  const SingleComment(
      {super.key,
      required this.postComment,
      required this.post,
      required this.callBackFunction});

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  MediaModel? post;
  CommentModel? postComment;
  Function? callBackFunction;

  bool isDeletable = false;

  //TODO commented time Function
  commentedTime(commentedTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(commentedTime);
    if (difference.inDays >= 1) {
      return DateFormat('MMM d').format(commentedTime);
    } else if (difference.inHours >= 1) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inSeconds <= 59) {
      return "${difference.inSeconds}s ago";
    } else {
      return "just now";
    }
  }

  isCommentDeletable() {
    setState(() {
      postComment!.commentOwnerId == usersModel!.userId ||
              post!.userId == usersModel!.userId
          ? isDeletable = true
          : isDeletable = false;
    });
  }

  @override
  void initState() {
    post = widget.post;
    postComment = widget.postComment;
    callBackFunction = widget.callBackFunction;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        isCommentDeletable();
      },
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: postComment!.commentOwnerDp.toString(),
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              backgroundImage: imageProvider,
            );
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postComment!.commentOwnerName.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(postComment!.commentContent.toString()),
            Text(
              commentedTime(postComment!.commentedTime),
            ),
          ],
        ),
        trailing: isDeletable
            ? IconButton(
                onPressed: () async {
                  await PostRepository.deleteCommentFromFirebase(
                      post!, postComment!);
                  callBackFunction!();
                  setState(() {
                    isDeletable = false;
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
