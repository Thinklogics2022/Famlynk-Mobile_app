import 'package:famlynk_version1/mvc/view/famlynkLogin/login/EmailLogin.dart';
import 'package:famlynk_version1/services/login&registerService/frgtPassword_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  bool isPasswordVisible = false;
  bool isConfirmPswdVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 228, 237),
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/lock.jpg",
                    height: 120,
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Email is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.green,
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
                            color: Colors.green,
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !isConfirmPswdVisible,
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.green,
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
                            color: Colors.green,
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
      final email = _emailController.text;
      final newPassword = _newPasswordController.text;
      ForgetPasswordService.resetPassword(email, newPassword);
      _flutterToast();

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  void _flutterToast() {
    Fluttertoast.showToast(
      msg: 'Password reset successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
    );
  }
}
