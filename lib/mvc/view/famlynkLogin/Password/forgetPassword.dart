import 'package:famlynk_version1/mvc/model/login_model/register_model.dart';
import 'package:famlynk_version1/mvc/view/famlynkLogin/Password/password.dart';
import 'package:famlynk_version1/services/forgetPswdService.dart';
import 'package:famlynk_version1/services/forgetPswdService.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../services/forgetPswdService.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
    RegisterModel registerModel = RegisterModel();

  late TextEditingController _emailController;
  late TextEditingController _otpController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _otpController = TextEditingController();
  }

  bool otpVisibility = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
        width: 50,
        height: 40,
        textStyle: TextStyle(fontSize: 22, color: Colors.black),
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 236, 241, 245),
            // color: const Color.fromARGB(255, 190, 202, 211),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 170,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Enter Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              labelStyle: TextStyle(fontSize: 10),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "* Email is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: _submitForm,
                          child: Text(
                            "Send OTP",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                if (otpVisibility)
                  Container(
                    height: 130,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Pinput(
                              controller: _otpController,
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: defaultPinTheme.decoration!
                                      .copyWith(
                                          border:
                                              Border.all(color: Colors.blue))),
                              onCompleted: (pin) => debugPrint(pin),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: TextButton(
                                  onPressed: _verifyOTP,
                                  // {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Pswd()));
                                  // },
                                  child: Text(
                                    "Verify",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      ForgetPasswordService forgetPasswordService = ForgetPasswordService();
      forgetPasswordService.getEmail(email);
      print(email);
      setState(() {
        otpVisibility = true;
      });
    }
  }

  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {
      final otp = _otpController.text;
      ForgetPasswordService forgetPasswordService = ForgetPasswordService();
      forgetPasswordService.getOTP(otp);
      print(otp);
      setState(() {

        otpVisibility = true;
      });
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => Pswd(email: _emailController.text)));
  }
}
