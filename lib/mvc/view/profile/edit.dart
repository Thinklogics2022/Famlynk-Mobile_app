import 'dart:io';
import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/model/profile_model/profile_model.dart';
import 'package:famlynk_version1/mvc/view/profile/userDetails.dart';
import 'package:famlynk_version1/mvc/view/suggestion/personal_detials.dart';
import 'package:famlynk_version1/services/editProfileService.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../services/profileEdit_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profileUserModel});

  final ProfileUserModel? profileUserModel;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController homeTownController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController _dateinput = TextEditingController();
  String _selectedGender = '';
  List<File> _imagesFile = [];
  @override
  void dispose() {
    nameController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController.text = widget.profileUserModel!.name.toString();
    _dateinput.text = widget.profileUserModel!.dateOfBirth.toString();
    emailController.text = widget.profileUserModel!.email.toString();
    mobileNumberController.text = widget.profileUserModel!.mobileNo.toString();
    _selectedGender = widget.profileUserModel!.gender.toString();

    super.initState();
  }

  Future<void> uploadImageToFirebaseStorage(File imageFile) async {
    String fileName = path.basename(imageFile.path);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(fileName);
    firebase_storage.UploadTask uploadTask =
        storageReference.putFile(imageFile);
    String downloadURL = await (await uploadTask).ref.getDownloadURL();
    print('Download URL: $downloadURL');
  }

  @override
  Widget build(BuildContext context) {
    MyProperties myProperties = MyProperties();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 228, 237),
      appBar: AppBar(
        title: Text("Edit Profile"),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              SizedBox(height: 25),
              // Text(
              //   "Edit Profile",
              //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              // ),
              SizedBox(height: 15),
              Center(
                child: Stack(
                  children: [
                    imageprofile(),
                  ],
                ),
              ),
              SizedBox(height: 35),
              buildTextField("Full Name", nameController, Icons.person),
              buildTextField("E-mail", emailController, Icons.email),
              buildTextField(
                  "Mobile Number", mobileNumberController, Icons.phone),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_add, color: Colors.grey, size: 25),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          SizedBox(height: 6),
                          Text("Male"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          SizedBox(height: 6),
                          Text("Female"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'others',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          SizedBox(height: 6),
                          Text("Others"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.5),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 12.5),
              TextField(
                controller: _dateinput,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_month),
                  fillColor: myProperties.fillColor,
                  hintText: 'Date Of Birth',
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2500));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _dateinput.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 25),
              buildTextField("Home Town", homeTownController, Icons.home),
              buildTextField("Address", addressController, Icons.location_city),
              buildTextField("MaritalStatus", maritalStatusController,
                  Icons.child_care_outlined),
              SizedBox(height: 35),
              ElevatedButton(
                onPressed: () {
                  EditProfileService editProfileService = EditProfileService();
                  if (formkey.currentState!.validate()) {
                    ProfileUserModel profileUserModel = ProfileUserModel(
                      name: nameController.text,
                      email: emailController.text,
                      mobileNo: mobileNumberController.text,
                      gender: _selectedGender,
                      dateOfBirth: _dateinput.text,
                      hometown: homeTownController.text,
                      address: addressController.text,
                      maritalStatus: maritalStatusController.text,
                      userId: widget.profileUserModel!.userId,
                      uniqueUserID:  widget.profileUserModel!.uniqueUserID
                    );
                    editProfileService.editProfile(profileUserModel);
                    // print(profileUserModel);
                    print(profileUserModel.mobileNo);
                    print(profileUserModel.hometown);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileUserDetails()));
                  }

                  // if (_imagesFile.isNotEmpty) {
                  //   uploadImageToFirebaseStorage(_imagesFile.first);
                  // } else {
                  //   print("object");
                  // }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                ),
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    TextEditingController controller,
    IconData? prefixIcon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 1),
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          labelStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget imageprofile() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 10),
                ),
              ],
              shape: BoxShape.circle,
              image: _imagesFile.isNotEmpty
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_imagesFile.first),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/FL04.png"),
                    ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text("Camera"),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text("Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagesFile.clear();
        _imagesFile.add(File(pickedFile.path));
      });
    }
  }
}
