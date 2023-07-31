// import 'package:famlynk_version1/mvc/controller/dropDown.dart';
// import 'package:flutter/material.dart';

// class MyAppss extends StatefulWidget {
//   @override
//   _MyAppssState createState() => _MyAppssState();
// }

// class _MyAppssState extends State<MyAppss> {
//   var selectedValueFromDropdown1;
//   var selectedValueFromDropdown2;
//   List<String> dropdown1Items = ["Option 1", "Option 2", "Option 3"];
//   List<String> dropdown2Items = ["Suboption 1", "Suboption 2", "Suboption 3"];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dropdown Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButton<String>(
//                 value: selectedValueFromDropdown1,
//                 items: dropdown1Items.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedValueFromDropdown1 = newValue!;
//                   });
//                 },
//               ),
//               if (selectedValueFromDropdown1 != null)
//                 DropdownButton<String>(
//                   value: selectedValueFromDropdown2,
//                   items: relation.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (newValue) {
//                     setState(() {
//                       selectedValueFromDropdown2 = newValue!;
//                     });
//                     print("Second dropdown selected: $newValue");
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
