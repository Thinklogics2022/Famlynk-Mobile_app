import 'dart:io';
import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/controller/dropDown.dart';
import 'package:famlynk_version1/mvc/model/addmember_model/addMember_model.dart';
import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
import 'package:famlynk_version1/services/familySevice/addMember_service.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref();
  File? imageFile;
  bool isLoading = false;
  // MyProperties myProperties = new MyProperties();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _phNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _dateinput = TextEditingController();

  String _selectedGender = '';
  String dropdownValue1 = 'Select Relation';
  // String? profilBase64;

  String userId = "";
  bool _isLoading = false;

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 223, 231, 237),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: HexColor('#0175C8'),
          title: Text(
            'Add Member',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    imageprofile(),
                    SizedBox(
                      height: 20,
                    ),
                    buildNameField(_name),
                    // SizedBox(height: 15),
                    Row(
                      children: [
                        buildGenderRow('male'),
                        buildGenderRow('female'),
                        buildGenderRow('others'),
                      ],
                    ),Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 15),
                    buildDateOfBirthField(_dateinput, () {
            _selectDateOfBirth(context);

                    }),
                    SizedBox(height: 15),
                    buildPhoneNumberField(_phNumber),
                    SizedBox(height: 15),
                    buildEmailField(_email),
                    SizedBox(height: 15),
                    buildRelationDropdown(),
                    SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#0175C8'),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            )
                          : Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepOrange,
        content: Text(
          message,
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

 Widget buildGenderRow(String value) {
  return Row(
    children: [
      Radio(
        value: value,
        
        groupValue: _selectedGender,
        onChanged: (value) {
          setState(() {
            _selectedGender = value as String;
          });
        },activeColor: Colors.orange,
      ),
      SizedBox(width: 6),
      Text(value),
    ],
  );
}

  void _selectDateOfBirth(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1999),
      lastDate: currentDate,
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateinput.text = formattedDate;
      });
    }
  }
  Widget buildRelationDropdown() {
    return Container(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 1),
          labelText: "Select Relation",
          
          prefixIcon: Icon(Icons.people),
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
        value: dropdownValue1,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue1 = newValue!;
          });
        },
        items: relation.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 15),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
//  _showSnackbar("Family Member added sucessfully", );
      String imageUrl = '';

      if (imageFile != null) {
        final storageResult = await storageRef
            .child('profile_images/${_name.text}')
            .putFile(imageFile!);
        imageUrl = await storageResult.ref.getDownloadURL();
      }

      AddMemberService addMemberService = AddMemberService();
      AddMemberModel addMemberModel = AddMemberModel(
        name: _name.text,
        gender: _selectedGender,
        firstLevelRelation: dropdownValue1,
        dob: _dateinput.text,
        userId: userId,
        email: _email.text,
        mobileNo: _phNumber.text,
        image: imageUrl,
      );

      addMemberService.addMemberPost(addMemberModel);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavBar(
            index: 3,
          ),
        ),
      );
    }
    //  else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NavBar(),
    //     ),
    //   );
    // }
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
                    blurRadius: 20,
                    color: Colors.blue.withOpacity(0.2),
                    offset: Offset(0, 10),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: imageFile == null
                    ? Center(
                        child: Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 153, 179, 201),
                        size: 100,
                      ))
                    : Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
              )),
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
                  color: Colors.blue,
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
            "Choose profile photo",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.deepOrange,
              fontStyle: FontStyle.italic
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      imageFile = File(pickedImage.path);
                    });
                  }
                },
                icon: Icon(Icons.image, color: Colors.deepOrange,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

