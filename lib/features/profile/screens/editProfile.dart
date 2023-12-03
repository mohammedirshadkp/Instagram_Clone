import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1_app/features/profile/repositories/profile_repositories.dart';
import '../../../Models/userModel.dart';
import '../../../core/constants/global-variables/global-variables.dart';
import '../../auth/controller/auth_controller.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  editUserProfile() async {
    usersModel = await getUserData(currentUserId);
    var updateDetails = usersModel!.copyWith(
        userName: _userName.text, userPhoneNumber: _userPhoneNumber.text);
    return updateDetails;
  }

  void myAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Background color
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.image_rounded),
                          Text('From Gallery'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Background color
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.camera_alt_rounded),
                          Text('From Camera'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
    ProfileRepositories.uploadImage(image!, context);
  }

  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _userPhoneNumber = TextEditingController();

  @override
  void initState() {
    _userPhoneNumber = TextEditingController(text: usersModel!.userPhoneNumber);
    _userName = TextEditingController(text: usersModel!.userName);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _userPhoneNumber.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Container(
          height: deviceHeight * .5,
          width: deviceWidth * .95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isEditable ? isEditable = false : isEditable = true;
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: deviceWidth * .2,
                      backgroundImage:
                          NetworkImage(usersModel!.imageUrl.toString()),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              myAlert(context);
                            },
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * .9,
                      height: deviceHeight * .08,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == '') {
                                  return "Field is empty";
                                } else {
                                  return null;
                                }
                              },
                              controller: _userName,
                              enabled: isEditable ? true : false,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(FontAwesomeIcons.user),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * .9,
                      height: deviceHeight * .08,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _userPhoneNumber,
                              maxLength: 10,
                              enabled: isEditable ? true : false,
                              decoration: InputDecoration(
                                hintText: usersModel!.userPhoneNumber == ''
                                    ? "Phone number"
                                    : null,
                                prefixIcon: const Icon(FontAwesomeIcons.phone),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.black)),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton.extended(
                      elevation: 0,
                      onPressed: () async {
                        var isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          var updateDetails = await editUserProfile();
                          ProfileRepositories.updateUserProfileToFirebase(
                              updateDetails: updateDetails, context: context);
                        }
                      },
                      label: const Text("Submit"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
