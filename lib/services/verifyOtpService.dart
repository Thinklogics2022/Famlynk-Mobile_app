import 'dart:convert';
import 'package:famlynk_version1/mvc/model/login_model/verifyOtpModel.dart';
import 'package:famlynk_version1/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class OTPService {
  Future<bool> verifyOTP(OTP otp) async {
    var url = FamlynkServiceUrl.verifyOtp;
    bool result = false;
    try {
      var response = await http.get(
        Uri.parse(url + otp.otp),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.body == 'OTP is correct') {
        result = true;
      }
    } catch (error) {
      print('Error verifying OTP: $error');
    }
    return result;
  }
}
