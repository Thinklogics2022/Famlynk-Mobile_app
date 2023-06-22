import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  MyProperties myProperties = MyProperties();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String _password = '';
  String _confirmPassword = "";
  bool isPasswordVisible = false;
  bool isConfirmPswdVisible = false;

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

  @override
  void initState() {
    Image.network("https://img.freepik.com/premium-vector/protected-personal-profile-private-user-blocked-user-account_435184-842.jpg?w=2000");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(32),
        elevation: 16,
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.network(
                      "https://img.freepik.com/premium-vector/protected-personal-profile-private-user-blocked-user-account_435184-842.jpg?w=2000",
                      height: 150,
                    ),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "*email is required";
                        }
                        if (validateEmail(value)) {
                          return "*valid email is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 35),
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
                    SizedBox(height: 35),
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
                    SizedBox(height: 25),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: myProperties.buttonColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Text(
                          'Set Password',
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
}
