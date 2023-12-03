import 'package:task1_app/Models/mediaModel.dart';

import '../../../Models/commentModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';

class PostRepository {
  // streams

  static Stream<List<CommentModel>> getPostCommentsStream(MediaModel post) {
    return post.postRef!
        .collection(FirebaseConstants.commentCollections)
        .orderBy("createdTime", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => CommentModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  //firebase

  static addPostToFirebase(MediaModel addPost) {
    usersModel!.ref!
        .collection(FirebaseConstants.mediaCollections)
        .add(addPost.toJson())
        .then((value) {
      var updateData = addPost.copyWith(postRef: value, postId: value.id);
      value.update(updateData.toJson());
    });
  }

  static addCommentToFirebase(
      {required MediaModel post, required CommentModel commentData}) async {
    await post.postRef!
        .collection(FirebaseConstants.commentCollections)
        .add(commentData.toJson())
        .then((value) async {
      var updateCommentData =
          commentData.copyWith(commentRef: value, commentId: value.id);
      await value.update(updateCommentData.toJson());
    });
  }

  static deleteCommentFromFirebase(
      MediaModel post, CommentModel postComment) async {
    await post.postRef!
        .collection(FirebaseConstants.commentCollections)
        .doc(postComment.commentId)
        .delete();
  }
}
