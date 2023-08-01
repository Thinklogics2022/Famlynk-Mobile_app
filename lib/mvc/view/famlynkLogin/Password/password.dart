import 'package:famlynk_version1/mvc/model/login_model/register_model.dart';
import 'package:famlynk_version1/services/forgetPswdService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Pswd extends StatefulWidget {
  Pswd({super.key, required this.email});
  String email;
  @override
  State<Pswd> createState() => _PswdState();
}

class _PswdState extends State<Pswd> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool isPasswordVisible = false;
  bool isConfirmPswdVisible = false;
  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password"),
      ),
      body: Card(
        child: Container(
          child: Form(
            key: _formKey,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                    child: Text(
                      "Change Your Password Here...",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
                    child: TextFormField(
                      controller: _newPasswordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'New Password',
                          hintStyle: const TextStyle(color: Colors.grey),
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
                              color: Colors.grey,
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* New password is required';
                        }
                        if (value.length < 8) {
                          return '* Password should be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !isConfirmPswdVisible,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Confirm Password',
                          hintStyle: const TextStyle(color: Colors.grey),
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
                              color: Colors.grey,
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Confirm password is required';
                        }
                        if (value != _newPasswordController.text) {
                          return '* Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newPassword = _newPasswordController.text;
      ForgetPasswordService forgetPasswordService = ForgetPasswordService();
      forgetPasswordService.forgetPassword(widget.email, newPassword);
      _flutterToast();
    }
  }

  void _flutterToast() {
    Fluttertoast.showToast(
      msg: 'Password updated successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }
}
