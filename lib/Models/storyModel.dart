import 'package:cloud_firestore/cloud_firestore.dart';

StoryModel? storyModel;

class StoryModel {
  String? storyId;
  String? storyContent;
  String? storyOwnerId;
  String? storyOwnerDp;
  String? storyOwnerName;
  DocumentReference? storyRef;
  DateTime? uploadedTime;
  List? storyViewersList;
  StoryModel(
      {this.storyId,
      required this.storyContent,
      required this.storyOwnerId,
      required this.storyOwnerDp,
      required this.storyOwnerName,
      required this.uploadedTime,
      this.storyViewersList,
      this.storyRef});

  StoryModel.fromJson(Map<String, dynamic> json) {
    storyId = json["storyId"] ?? "";
    storyContent = json["storyContent"] ?? "";
    storyOwnerName = json["storyOwnerName"] ?? "";
    storyOwnerId = json["storyOwnerId"] ?? "";
    storyOwnerDp = json["storyOwnerDp"] ?? "";
    storyRef = json["storyRef"];
    storyViewersList = json["viewers"] ?? [];
    uploadedTime = json["uploadedTime"] == null
        ? DateTime.now()
        : json['uploadedTime'].toDate();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["storyId"] = storyId;
    data["storyContent"] = storyContent;
    data["storyOwnerName"] = storyOwnerName;
    data["storyOwnerId"] = storyOwnerId;
    data["storyOwnerDp"] = storyOwnerDp;
    data["storyRef"] = storyRef;
    data["viewers"] = storyViewersList;
    data["uploadedTime"] = uploadedTime;
    return data;
  }
}
