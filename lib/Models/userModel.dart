import 'package:cloud_firestore/cloud_firestore.dart';

UsersModel? usersModel;

class UsersModel {
  late String userName;
  late String userEmail;
  late String userPhoneNumber;
  late String userPassword;
  late String imageUrl;
  late String userId;
  late DateTime createDate;
  late DateTime lastLogged;
  DocumentReference? ref;
  late List followersList;
  late List saved;
  UsersModel(
      {required this.userId,
      required this.userEmail,
      required this.userName,
      required this.userPhoneNumber,
      required this.userPassword,
      required this.imageUrl,
      required this.createDate,
      required this.lastLogged,
      this.ref,
      required this.followersList,
      required this.saved});

  UsersModel.fromJson(Map<String, dynamic> json) {
    userName = json["userName"] ?? '';
    userEmail = json["email"] ?? '';
    userPassword = json["password"] ?? '';
    userPhoneNumber = json["phoneNo"] ?? '';
    createDate = json["createDate"] == null
        ? DateTime.now()
        : json["createDate"].toDate();
    lastLogged = json["lastLogged"] == null
        ? DateTime.now()
        : json["lastLogged"].toDate();
    imageUrl = json["dp"] ?? '';
    userId = json["uid"] ?? "";
    ref = json["ref"];
    followersList = json["followers"] ?? [];
    saved = json["saved"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userName"] = userName;
    data["email"] = userEmail;
    data["password"] = userPassword;
    data["phoneNo"] = userPhoneNumber;
    data["lastLogged"] = lastLogged;
    data['createDate'] = createDate;
    data['dp'] = imageUrl;
    data['uid'] = userId;
    data["ref"] = ref;
    data["followers"] = followersList;
    data["saved"] = saved;
    return data;
  }

  UsersModel copyWith({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
    String? userPassword,
    String? imageUrl,
    String? userId,
    DateTime? createDate,
    DateTime? lastLogged,
    DocumentReference? ref,
    List? followersList,
    List? saved,
  }) {
    return UsersModel(
        userEmail: userEmail ?? this.userEmail,
        userName: userName ?? this.userName,
        userPhoneNumber: userPhoneNumber ?? this.userPhoneNumber,
        userPassword: userPassword ?? this.userPassword,
        imageUrl: imageUrl ?? this.imageUrl,
        createDate: createDate ?? this.createDate,
        lastLogged: lastLogged ?? this.lastLogged,
        userId: userId ?? this.userId,
        ref: ref ?? this.ref,
        followersList: followersList ?? this.followersList,
        saved: saved ?? this.saved);
  }
}
