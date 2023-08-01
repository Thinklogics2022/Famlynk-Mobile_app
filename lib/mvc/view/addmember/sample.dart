// // import 'package:flutter/material.dart';
// // import 'package:flutter_profile_picture/flutter_profile_picture.dart';

// // class Sample extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Profile Picture Example'),
// //       ),
// //       body: Center(
// //         child:ProfilePicture(
// //     name: 'Deepak',
// //     radius: 31,
// //     fontsize: 21,
// //     random: true,
// // )
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';



// class OTPField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: OtpScreen(),
//     );
//   }
// }

// class OtpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Screen'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 32.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               PinCodeTextField(
//                 appContext: context,
//                 length: 6, // Length of the OTP (can be customized)
//                 onChanged: (value) {
//                   // This callback will be triggered when the OTP changes
//                   print(value);
//                 },
//                 onCompleted: (value) {
//                   // This callback will be triggered when the user completes entering the OTP
//                   print("Completed: $value");
//                 },
//                 // Other customization options:
//                 // You can customize the appearance and behavior of the OTP field using various properties
//                 // Check the package documentation for more customization options.
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement your logic to verify the OTP here
//                   // For example, you can compare the entered OTP with the expected OTP and show a success or error message accordingly.
//                 },
//                 child: Text('Verify OTP'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

