// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../constants/constVariables.dart';
// import '../../../controller/dropDown.dart';

// class FamMember extends StatefulWidget {
//   @override
//   _FamMemberState createState() => _FamMemberState();
// }

// class _FamMemberState extends State<FamMember> {
//   // TextEditingController _dateinput = TextEditingController();

//   String _selectedGender = '';
//   // DateTime Date = DateTime.now();

//   String? profilBase64;
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   void _pickImageBase64() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return;

//     List<int> imagebyte = await image.readAsBytes();

//     profilBase64 = base64.encode(imagebyte);

//     final imagetemppath = File(image.path);
//     setState(() {
//       this._imageFile = imagetemppath;
//     });
//   }

//   @override
//   void initState() {
//     // _dateinput.text = "";
//     super.initState();
//   }

//   MyProperties myProperties = new MyProperties();
//   String dropdownValue1 = 'Select Relation';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Family Member',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           // backgroundColor: Color.fromARGB(255, 0, 77, 209),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(children: [
//                 imageprofile(_imageFile),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       icon: Icon(Icons.person), hintText: "Name"),
//                 ),
//                 SizedBox(height: 12),

//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Gender"),
//                     Row(
//                       children: [
//                         Row(
//                           children: [
//                             Radio(
//                               value: 'Male',
//                               groupValue: _selectedGender,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedGender = value!;
//                                 });
//                               },
//                             ),
//                             SizedBox(height: 6),
//                             Text("Male"),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Radio(
//                               value: 'female',
//                               groupValue: _selectedGender,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedGender = value!;
//                                 });
//                               },
//                             ),
//                             SizedBox(height: 6),
//                             Text("Female"),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Radio(
//                               value: 'others',
//                               groupValue: _selectedGender,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedGender = value!;
//                                 });
//                               },
//                             ),
//                             SizedBox(height: 6),
//                             Text("Others"),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),

//                 Container(
//                   child: DropdownButtonFormField(
//                     decoration: InputDecoration(prefixIcon: Icon(Icons.people)),
//                     dropdownColor: Color.fromARGB(255, 255, 255, 255),
//                     value: dropdownValue1,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         dropdownValue1 = newValue!;
//                       });
//                     },
//                     items:
//                         relation.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(height: 12),

//                 // TextFormField(
//                 //   controller: _dateinput,
//                 //   keyboardType: TextInputType.datetime,
//                 //   decoration: InputDecoration(
//                 //       icon: Icon(Icons.calendar_month),
//                 //       labelText: "YYYY/MM/DD"),
//                 //   onTap: () async {
//                 //     DateTime? pickedDate = await showDatePicker(
//                 //         context: context,
//                 //         initialDate: DateTime.now(),
//                 //         firstDate: DateTime(1900),
//                 //         lastDate: DateTime(2500));
//                 //     if (pickedDate != null) {
//                 //       String formattedDate =
//                 //           DateFormat('yyyy-MM-dd').format(pickedDate);
//                 //       setState(() {
//                 //         _dateinput.text = formattedDate;
//                 //       });
//                 //     }
//                 //   },
//                 // ),

//                 TextFormField(
//                   decoration: InputDecoration(
//                       icon: Icon(Icons.phone), hintText: "Mobile Number"),
//                   keyboardType: TextInputType.phone,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Submit"),
//                 ),
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget imageprofile(File? imageFile) {
//     return Center(
//       child: Stack(
//         children: <Widget>[
//           Container(
//             width: 130,
//             height: 130,
//             child: GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: ((builder) => bottomSheet()),
//                   );
//                 },
//                 child: ClipOval(
//                   child: _imageFile == null
//                       ? Center(
//                           child: Icon(
//                           Icons.account_circle,
//                           color: Color.fromARGB(255, 124, 124, 124),
//                           size: 140,
//                         ))
//                       : Image.file(
//                           _imageFile!,
//                           fit: BoxFit.cover,
//                         ),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget bottomSheet() {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(
//         children: <Widget>[
//           Text(
//             "Choose profile photo",
//             style: TextStyle(
//               fontSize: 20.0,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               IconButton(
//                 onPressed: () {
//                   _pickImageBase64();
//                 },
//                 icon: Icon(Icons.image),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
