import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1_app/features/post/repositories/post_repository.dart';
import '../../../Models/mediaModel.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/Firebase/firebase_constants.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../Home-insta/screens/clone_homepage.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  bool isReadyToUpload = false;
  bool uploadButton = false;
  XFile? post;
  var postUrl;
  final TextEditingController _description = TextEditingController();
  final ImagePicker picker = ImagePicker();

  //TODO getImage and Upload image setstate

  getImage(ImageSource media) async {
    var img = await picker.pickImage(
      source: media,
      imageQuality: 50,
    );
    setState(() {
      post = img;
    });
    uploadPostToFirebaseStorage(post!);
  }

  uploadPostToFirebaseStorage(XFile post) {
    var ref = FirebaseStorage.instance
        .ref()
        .child("posts-Fahiz/postname-${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(File(post.path));
    uploadTask
        .then((p0) async => postUrl = (await ref.getDownloadURL()).toString())
        .then((value) {
      setState(() {
        isReadyToUpload = true;
      });
    });
  }

  uploadPost() {
    var addPost = MediaModel(
      postDescription: _description.text,
      uploadedTime: DateTime.now(),
      userId: currentUserId,
      postUrl: postUrl,
      likesList: [],
      userName: usersModel!.userName,
    );
    PostRepository.addPostToFirebase(addPost);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false);
  }

  notReadyToUpload() {
    const snackBar =
        SnackBar(content: Text("Your post is processing please wait..."));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: deviceHeight * .05,
        ),
        Container(
            height: deviceHeight * .4,
            width: deviceWidth * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(255, 246, 224, 1),
            ),
            child: post != null
                ? InteractiveViewer(
                    child: Image.file(
                      File(post!.path),
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : const Center(
                    child: Text(
                    "Select an image",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                getImage(ImageSource.camera);
              },
              child: Container(
                height: deviceHeight * .1,
                width: deviceWidth * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(255, 246, 224, 1),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                    ),
                    Text(
                      "From camera",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              child: Container(
                height: deviceHeight * .1,
                width: deviceWidth * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(255, 246, 224, 1),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.file_copy_outlined,
                      size: 50,
                    ),
                    Text(
                      "From gallery",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: deviceHeight * .15,
          width: deviceWidth * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromRGBO(255, 246, 224, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextFormField(
                controller: _description,
              ),
            ],
          ),
        ),
        FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(255, 246, 224, 1),
          elevation: 0,
          shape: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          onPressed: () {
            isReadyToUpload ? uploadPost() : notReadyToUpload();
          },
          label: const Text(
            "Upload post",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
