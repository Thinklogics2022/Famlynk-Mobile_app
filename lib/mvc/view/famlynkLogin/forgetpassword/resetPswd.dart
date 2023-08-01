import 'package:famlynk_version1/mvc/view/famlynkLogin/login/EmailLogin.dart';
import 'package:famlynk_version1/services/resetPswdService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                        "assets/images/lock.jpg",
                      ),
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1),
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email,
                            color: const Color.fromARGB(255, 83, 81, 81)),
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
                          contentPadding: EdgeInsets.only(bottom: 1),
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                             color: const Color.fromARGB(255, 93, 91, 91),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 93, 91, 91),
                          ),
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
                              color: Colors.orange,
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
                          contentPadding: EdgeInsets.only(bottom: 1),
                          labelText: "Confirm Password",
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: const Color.fromARGB(255, 93, 91, 91),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 77, 77, 77),
                          ),
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
                              color: Colors.orange,
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
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final newPassword = _newPasswordController.text;
      ResetPasswordService.resetPassword(email, newPassword);
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
