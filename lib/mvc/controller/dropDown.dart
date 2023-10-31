import 'package:flutter/material.dart';

const List<String> relation = <String>[
  "Select Relation",
  'father',
  'mother',
  'sister',
  'brother',
  'wife',
  'husband',
  'daughter',
  'son',
  'grandfather',
  'grandmother',
];

const List<String> maritalStatus = <String>["Single", "Marrried"];

class NameAvatar extends StatelessWidget {
  final String? name;
  final double radius;
  final String? img;

  NameAvatar({this.name, this.radius = 30, this.img});

  // Color _getRandomColor() {
  //   final colors = [
  //     Colors.red,
  //     Colors.green,
  //     Colors.blue,
  //     Colors.orange,
  //     Colors.purple,
  //     Colors.pink,
  //     Colors.teal,
  //   ];
  //   return colors[name.hashCode % colors.length];
  // }

  @override
  Widget build(BuildContext context) {
    final initials = name!.isNotEmpty ? name![0].toUpperCase() : '?';

    return CircleAvatar(
      radius: radius,
      // backgroundColor: _getRandomColor(),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.6,
        ),
      ),
    );
  }
}

class ColorMapping {
  static Map<String, Color> letterToColor = {
    'A': Colors.blue,
    'B': Color.fromARGB(255, 222, 45, 33),
    'C': Colors.green,
    "D": Colors.blue,
    "E": Colors.lightGreen,
    "F": Colors.amber,
    "G": Colors.blueAccent,
    "H": Colors.blueGrey,
    "I": Colors.brown,
    "J": Colors.indigo,
    "K": Colors.pinkAccent,
    "L": Colors.deepOrange,
    "M": Colors.deepOrangeAccent,
    "N": Colors.deepPurple,
    "O": Colors.deepPurpleAccent,
    "P": Colors.green,
    "Q": Colors.greenAccent,
    'R': Colors.red,
    'S': Colors.green,
    "T": Colors.orangeAccent,
    "U": Colors.blueGrey,
    "V": Colors.blue,
    "W": Colors.blueAccent,
    "X": Colors.blueGrey,
    'Y': Colors.orangeAccent,
    'Z': Colors.yellow,
  };

  static Color getColorForLetter(String letter) {
    return letterToColor[letter] ?? Colors.grey;
  }
}

Widget defaultImage(String image, String name) {
  if (image.isEmpty || image == "null") {
    String firstLetter = name.isNotEmpty ? name[0].toUpperCase() : "?";
    Color letterColor = ColorMapping.getColorForLetter(firstLetter);
    return CircleAvatar(
      radius: 40,
      backgroundColor: letterColor,
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  } else {
    return CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(image),
    );
  }
}
