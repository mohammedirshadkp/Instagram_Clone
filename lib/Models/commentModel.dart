import 'package:cloud_firestore/cloud_firestore.dart';

CommentModel? commentModel;

class CommentModel {
  String? commentId;
  String? commentOwnerId;
  String? commentOwnerName;
  String? commentOwnerDp;
  String? commentContent;
  DateTime? commentedTime;
  DocumentReference? commentRef;

  CommentModel({
    this.commentId,
    required this.commentOwnerId,
    required this.commentOwnerDp,
    required this.commentOwnerName,
    required this.commentContent,
    required this.commentedTime,
    this.commentRef,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json["commentId"] ?? "";
    commentContent = json["commentContent"] ?? "";
    commentOwnerId = json["commentOwnerId"] ?? "";
    commentOwnerName = json["commentOwnerName"] ?? "";
    commentOwnerDp = json["commentOwnerDp"] ?? "";
    commentedTime = json["createdTime"] == null
        ? DateTime.now()
        : json["createdTime"].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["commentId"] = commentId;
    data["commentContent"] = commentContent;
    data["commentOwnerId"] = commentOwnerId;
    data["createdTime"] = commentedTime;
    data["commentRef"] = commentRef;
    data["commentOwnerName"] = commentOwnerName;
    data["commentOwnerDp"] = commentOwnerDp;
    return data;
  }

  CommentModel copyWith({
    String? commentId,
    String? commentOwnerId,
    String? commentContent,
    String? commentOwnerName,
    String? commentOwnerDp,
    DateTime? commentedTime,
    DocumentReference? commentRef,
  }) {
    return CommentModel(
        commentOwnerId: commentOwnerId ?? this.commentOwnerId,
        commentContent: commentContent ?? this.commentContent,
        commentedTime: commentedTime ?? this.commentedTime,
        commentId: commentId ?? this.commentId,
        commentRef: commentRef ?? this.commentRef,
        commentOwnerDp: commentOwnerDp ?? this.commentOwnerDp,
        commentOwnerName: commentOwnerName ?? this.commentOwnerName);
  }
}
