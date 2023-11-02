import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProperties {
  Color backgroundColor = HexColor('#0175C8');
  Color buttonColor = HexColor('#0175C8');
  double fontSize = 18.0;
  Color textColor = HexColor('#0175C8');
  Color fillColor = Colors.grey.shade200;
}

// Widget buildNameField(
//   TextEditingController controller,
// ) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 25.0),
//     child: TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(bottom: 1),
//         labelText: "Enter Name",
//         prefixIcon: Icon(Icons.person),
//         labelStyle: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         hintStyle: TextStyle(
//           fontSize: 26,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "*name is required";
//         }
//         return null;
//       },
//     ),
//   );
// }

// Widget buildPhoneNumberField(TextEditingController controller) {
//   controller.addListener(() {
//     String text = controller.text;
//     String digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');
//     if (digitsOnly.length > 10) {
//       digitsOnly = digitsOnly.substring(0, 10);
//     }
//     if (digitsOnly != text) {
//       controller.value = controller.value.copyWith(
//         text: digitsOnly,
//         selection: TextSelection.collapsed(offset: digitsOnly.length),
//       );
//     }
//   });

//   return TextFormField(
//     controller: controller,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.only(bottom: 1),
//       labelText: "Enter Mobile Number",
//       prefixIcon: Icon(Icons.phone),
//       labelStyle: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       floatingLabelBehavior: FloatingLabelBehavior.always,
//       hintStyle: TextStyle(
//         fontSize: 26,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     keyboardType: TextInputType.phone,
//     validator: (value) {
//       String digitsOnly = value!.replaceAll(RegExp(r'[^0-9]'), '');
//       if (digitsOnly.length != 10) {
//         return "*enter a valid 10-digit mobile number";
//       }
//     },
//   );
// }

// Widget buildEmailField(TextEditingController controller) {
//   return TextFormField(
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(bottom: 1),
//         labelText: "Enter Email",
//         prefixIcon: Icon(Icons.email),
//         labelStyle: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         hintStyle: TextStyle(
//           fontSize: 26,
//           fontWeight: FontWeight.bold,
//           color: Colors.black,
//         ),
//       ),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return "*email is required";
//         }
//         if (validateEmail(value)) {
//           return "*valid email is required";
//         }
//       });
// }

// bool validateEmail(String value) {
//   const emailRegex = r"^[a-zA-Z0-9+_.-]+@gmail\.com$";
//   final RegExp regex = RegExp(emailRegex);
//   return !regex.hasMatch(value);
// }

// Widget buildDateOfBirthField(TextEditingController controller, Function onTap) {
//   return TextFormField(
//     keyboardType: TextInputType.datetime,
//     controller: controller,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.only(bottom: 1),
//       labelText: "Enter DOB",
//       prefixIcon: Icon(Icons.calendar_month),
//       labelStyle: TextStyle(
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       floatingLabelBehavior: FloatingLabelBehavior.always,
//       hintStyle: TextStyle(
//         fontSize: 26,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//     onTap: () {
//       onTap();
//     },
//     validator: (value) {
//       if (value!.isEmpty) {
//         return '*dob is required';
//       } else {
//         return null;
//       }
//     },
//   );
// }

         

// class FirebaseUtils {
//   static firebase_storage.Reference storageRef =
//       firebase_storage.FirebaseStorage.instance.ref();

//   static Future<File?> getImageFile(String imagePath) async {
//     try {
//       final String downloadUrl = await storageRef.child(imagePath).getDownloadURL();
//       final HttpClient httpClient = HttpClient();
//       final HttpClientRequest request = await httpClient.getUrl(Uri.parse(downloadUrl));
//       final HttpClientResponse response = await request.close();
//       if (response.statusCode == 200) {
//         final bytes = await consolidateHttpClientResponseBytes(response);
//         final tempDir = await getTemporaryDirectory();
//         final File file = File('${tempDir.path}/temp_image.jpg');
//         await file.writeAsBytes(bytes);
//         return file;
//       }
//     } catch (e) {
//       print('Error getting image from Firebase: $e');
//     }
//     return null;
//   }
// }