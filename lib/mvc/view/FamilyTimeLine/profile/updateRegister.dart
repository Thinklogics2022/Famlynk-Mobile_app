import 'dart:convert';
import 'dart:io';
import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:famlynk_version1/mvc/model/registerModel.dart';
import 'package:famlynk_version1/mvc/view/FamilyTimeLine/profile/profile.dart';
import 'package:famlynk_version1/mvc/view/famLogin.dart/EmailLogin.dart';
import 'package:famlynk_version1/services/registerService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/updateRegisterModel.dart';

class UpdateRegister extends StatefulWidget {
  // UpdateRegisterModel? updateRegisterModel;
  @override
  _UpdateRegisterState createState() => _UpdateRegisterState();
}

class _UpdateRegisterState extends State<UpdateRegister> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phnController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _dateinput = TextEditingController();

  bool validateEmail(String value) {
    const emailRegex = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]";
    final RegExp regex = RegExp(emailRegex);
    return !regex.hasMatch(value);
  }

  bool validatePassword(String value) {
    const passwordRegex = '^[A-Za-z0-9@%*#?&]{8,16}';
    final RegExp regex = RegExp(passwordRegex);
    return !regex.hasMatch(value);
  }

  bool validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^\+[1-9]{1}[0-9]{3,14}$');
    return regex.hasMatch(phoneNumber);
  }

  bool isPasswordVisible = false;
  bool isConfirmPswdVisible = false;
  String _selectedGender = '';
  DateTime Date = DateTime.now();
  DateTime? startDate;
  String _password = '';
  String _confirmPassword = '';

  // String? profilBase64;
  // File? _imageFile;
  // final ImagePicker _picker = ImagePicker();

  // void _pickImageBase64() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return;

  //   List<int> imagebyte = await image.readAsBytes();

  //   profilBase64 = base64.encode(imagebyte);

  //   final imagetemppath = File(image.path);
  //   setState(() {
  //     this._imageFile = imagetemppath;
  //   });
  // }

  @override
  void initState() {
    // _nameController.text = widget.updateRegisterModel!.name.toString();
    // _phnController.text = widget.updateRegisterModel!.phoneNumber.toString();
    // _dateinput.text = widget.updateRegisterModel!.dateOfBirth.toString();
    // _passwordController.text = widget.updateRegisterModel!.password.toString();
    // _emailController.text = widget.updateRegisterModel!.email.toString();
    // _dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyProperties myProperties = MyProperties();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Registration',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: myProperties.backgroundColor,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Register your account",
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: const Color.fromARGB(255, 62, 141, 141)),
                    ),
                    // imageprofile(_imageFile),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Enter Your Name',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return '*name is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_add,
                                color: Colors.grey, size: 25),
                            SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Male',
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
                              ]
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
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _dateinput,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_month),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Date Of Birth',
                          hintStyle: TextStyle(color: Colors.grey[500])),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*dob is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _phnController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*mobile number is required";
                        }
                        if (value.length != 10) {
                          return "*mobile number must be 10";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*email is required";
                        }
                        if (validateEmail(value)) {
                          return "*valid email is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*password is required';
                        }
                        if (value.length < 8) {
                          return '*password should be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !isConfirmPswdVisible,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isConfirmPswdVisible = !isConfirmPswdVisible;
                              });
                            },
                            child: Icon(
                              isConfirmPswdVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _confirmPassword = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '*confirm password is required';
                          }
                          if (value != _password) {
                            return '*confirm password not matching';
                          }
                          return null;
                        }),
                    SizedBox(height: 35),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myProperties.buttonColor,
                        ),
                        onPressed: () {
                          RegisterService registerService = RegisterService();
                        
                          if (_formKey.currentState!.validate()) {
                            RegisterModel registerModel = RegisterModel(
                              name: _nameController.text,
                              gender: _selectedGender,
                              dateOfBirth: _dateinput.text,
                              password: _passwordController.text,
                              email: _emailController.text,
                              phoneNumber: _phnController.text,
                              // profileImage: profilBase64 ?? ""
                            );
                            registerService.AddPostMethod(registerModel);
                            print(registerModel.dateOfBirth);
                            print(registerModel.phoneNumber);
                            // print(registerModel);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
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

  // Widget imageprofile(File? imageFile) {
  //   return Center(
  //     child: Stack(
  //       children: <Widget>[
  //         Container(
  //           width: 130,
  //           height: 130,
  //           child: GestureDetector(
  //               onTap: () {
  //                 showModalBottomSheet(
  //                   context: context,
  //                   builder: ((builder) => bottomSheet()),
  //                 );
  //               },
  //               child: ClipOval(
  //                 child: _imageFile == null
  //                     ? Center(
  //                         child: Icon(
  //                         Icons.account_circle,
  //                         color: Color.fromARGB(255, 124, 124, 124),
  //                         size: 140,
  //                       ))
  //                     : Image.file(
  //                         _imageFile!,
  //                         fit: BoxFit.cover,
  //                       ),
  //               )),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget bottomSheet() {
  //   return Container(
  //     height: 100,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Choose profile photo",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: <Widget>[
  //             IconButton(
  //               onPressed: () {
  //                 _pickImageBase64();
  //               },
  //               icon: Icon(Icons.image),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
