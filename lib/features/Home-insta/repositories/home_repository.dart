import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';

class HomeRepository {
  static Stream<List<MediaModel>> getFeedPost() {
    return FirebaseFirestore.instance
        .collectionGroup(FirebaseConstants.mediaCollections)
        .orderBy("uploadedTime", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MediaModel.fromJson(doc.data()))
            .toList());
  }

  static updateLikeToFirebase(MediaModel post) {
    var likeData = post.copyWith(likesList: post.likesList);
    post.postRef!.update(likeData.toJson());
  }

  static updateSavedToFirebase(UsersModel usersModel) {
    var updateSaved = usersModel.copyWith(saved: usersModel.saved);
    usersModel.ref!.update(updateSaved.toJson());
  }
}
