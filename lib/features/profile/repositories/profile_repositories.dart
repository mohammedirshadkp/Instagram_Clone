import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../auth/controller/auth_controller.dart';
import '../screens/profilePage.dart';

class ProfileRepositories {
  //editUserProfile

  static updateUserProfileToFirebase(
      {required updateDetails, required BuildContext context}) {
    usersModel!.ref!.update(updateDetails.toJson()).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              user: usersModel!,
            ),
          ),
          (route) => false);
    });
  }

  //editProfile upload image to firebase

  static uploadImage(XFile image, BuildContext context) {
    String url = "";
    var ref = FirebaseStorage.instance
        .ref()
        .child('/images/imageName-${DateTime.now()}');
    UploadTask uploadTask = ref.putFile(File(image.path));
    uploadTask
        .then((res) async => url = (await ref.getDownloadURL()).toString())
        .then((value) async {
      usersModel = await getUserData(currentUserId);
      var updateData = usersModel!.copyWith(imageUrl: url);
      usersModel!.ref!
          .update(updateData.toJson())
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(user: usersModel!),
              ),
              (route) => false));
    });
  }

  //following
  static Stream<List<UsersModel>> getFollowingStream(UsersModel user) {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollections)
        .where('followers', arrayContains: user.userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => UsersModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  //update following
  static updateFollowingToFirebase(UsersModel followingUser) {
    var updateFollowing =
        followingUser.copyWith(followersList: followingUser.followersList);
    followingUser.ref!.update(updateFollowing.toJson());
  }

  //followers features
  static Future<List<UsersModel>> getFollowers(
      {required UsersModel user, required followersList}) async {
    for (var followerId in user.followersList) {
      FirebaseFirestore.instance
          .collection(FirebaseConstants.userCollections)
          .doc(followerId)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          followersList.add(UsersModel.fromJson(snapshot.data()!));
        }
      });
    }
    return followersList;
  }

  //my posts
  static Stream<List<MediaModel>> getCurrentUserPostsStream(UsersModel user) {
    return user.ref!
        .collection(FirebaseConstants.mediaCollections)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MediaModel.fromJson(doc.data()))
            .toList());
  }

  //edit post
  static editUserPost(
      {required MediaModel post,
      required BuildContext context,
      required TextEditingController editDescription}) {
    var editPost = post.copyWith(postDescription: editDescription.text);
    post.postRef!.update(editPost.toJson()).then((value) {
      Navigator.pop(context);
      const snackBar = SnackBar(content: Text("Edit successfull"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  // delete post
  static deletePostFromFirebase(MediaModel post, BuildContext context) {
    post.postRef!.delete().then((value) {
      Navigator.pop(context);
      const snackBar = SnackBar(content: Text("Post deleted"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
