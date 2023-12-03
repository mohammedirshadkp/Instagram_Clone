import 'package:cloud_firestore/cloud_firestore.dart';

late MediaModel mediaModel;

class MediaModel {
  String? userId;
  String? userName;
  String? postDescription;
  List? likesList;
  DateTime? uploadedTime;
  String? postUrl;
  DocumentReference? postRef;
  String? postId;

  MediaModel({
    required this.userId,
    required this.postUrl,
    required this.postDescription,
    required this.likesList,
    required this.userName,
    required this.uploadedTime,
    this.postRef,
    this.postId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userName"] = userName;
    data["userId"] = userId;
    data["likes"] = likesList;
    data["postUrl"] = postUrl;
    data["uploadedTime"] = uploadedTime;
    data["description"] = postDescription;
    data["ref"] = postRef;
    data["postId"] = postId;

    return data;
  }

  MediaModel.fromJson(Map<String, dynamic> json) {
    userName = json["userName"] ?? '';
    userId = json["userId"] ?? '';
    likesList = json["likes"] ?? [];
    postDescription = json["description"] ?? '';
    uploadedTime = json["uploadedTime"] == null
        ? DateTime.now()
        : json["uploadedTime"].toDate();
    postUrl = json["postUrl"] ?? "";
    postRef = json["ref"];
    postId = json["postId"];
  }

  MediaModel copyWith({
    String? userId,
    String? userName,
    String? postDescription,
    List? likesList,
    DateTime? uploadedTime,
    String? postUrl,
    String? postId,
    DocumentReference? postRef,
  }) {
    return MediaModel(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      uploadedTime: uploadedTime ?? this.uploadedTime,
      likesList: likesList ?? this.likesList,
      postDescription: postDescription ?? this.postDescription,
      postUrl: postUrl ?? this.postUrl,
      postRef: postRef ?? this.postRef,
    );
  }
}
