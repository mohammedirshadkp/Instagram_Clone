import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';

class SavedRepositories {
  //get save posts

  static Stream<List<MediaModel>> getSavedPostsStream(String postId) {
    return FirebaseFirestore.instance
        .collectionGroup(FirebaseConstants.mediaCollections)
        .where("postId", isEqualTo: postId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MediaModel.fromJson(doc.data()))
            .toList());
  }

  //un save post
  static unSavePost(
      {required MediaModel savedPost,
      required BuildContext context,
      required Function callBackFunction}) {
    usersModel!.saved.remove(savedPost.postId);
    var updateData = usersModel!.copyWith(saved: usersModel!.saved);
    usersModel!.ref!.update(updateData.toJson()).then((value) {
      callBackFunction();
      Navigator.pop(context);
    });
  }
}
