import 'package:task1_app/Models/userModel.dart';

class SocialRepositories {
  static addFollowUnFollowToFirebase(
      {required UsersModel user, required List followList}) {
    var updateFollow = user.copyWith(followersList: followList);
    user.ref!.update(updateFollow.toJson());
  }
}
