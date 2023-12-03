import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task1_app/features/profile/repositories/profile_repositories.dart';
import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';

class UserPostPage extends StatefulWidget {
  final UsersModel user;
  const UserPostPage({super.key, required this.user});

  @override
  State<UserPostPage> createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {
  UsersModel? user;
  final TextEditingController _editDescription = TextEditingController();

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: deviceHeight * .55,
      width: deviceWidth,
      child: StreamBuilder(
          stream: ProfileRepositories.getCurrentUserPostsStream(user!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userPosts = snapshot.data;
              return GridView.builder(
                itemCount: userPosts!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              iconTheme:
                                  const IconThemeData(color: Colors.black),
                            ),
                            body: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: deviceWidth,
                                  height: deviceHeight * .7,
                                  child: InteractiveViewer(
                                    child: Image(
                                      image: NetworkImage(
                                          userPosts[index].postUrl!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    user!.userId == currentUserId
                                        ? FloatingActionButton.extended(
                                            elevation: 0,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    92, 75, 153, 1),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  content: TextFormField(
                                                    controller:
                                                        _editDescription,
                                                    decoration: InputDecoration(
                                                        hintText: userPosts[
                                                                index]
                                                            .postDescription),
                                                  ),
                                                  actions: [
                                                    FloatingActionButton
                                                        .extended(
                                                      elevation: 0,
                                                      onPressed: () {
                                                        ProfileRepositories
                                                            .editUserPost(
                                                                post: userPosts[
                                                                    index],
                                                                context:
                                                                    context,
                                                                editDescription:
                                                                    _editDescription);
                                                      },
                                                      label: const Text(
                                                          "Save edits"),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            label: const Text("Edit post"),
                                          )
                                        : const SizedBox(),
                                    user!.userId == currentUserId
                                        ? FloatingActionButton.extended(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    92, 75, 153, 1),
                                            elevation: 0,
                                            onPressed: () {
                                              ProfileRepositories
                                                  .deletePostFromFirebase(
                                                      userPosts[index],
                                                      context);
                                            },
                                            label: const Text("Delete post"),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: (124 / deviceWidth) * deviceWidth,
                      width: (124 / deviceWidth) * deviceWidth,
                      color: const Color.fromRGBO(248, 246, 244, 1),
                      child: CachedNetworkImage(
                        imageUrl: userPosts[index].postUrl!,
                        fit: BoxFit.fill,
                        height: (124 / deviceHeight) * deviceHeight,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
