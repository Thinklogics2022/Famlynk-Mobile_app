import 'package:flutter/material.dart';

class MyComment extends StatefulWidget {
  const MyComment({super.key});

  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
  List<String> dataList = ["Gokul Comment on pandi Post ", "Item 2", "Item 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>particularComment(name: "name", gender: "gender", dateOfBirth: "dateOfBirth")));
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(dataList[index]),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class particularComment extends StatefulWidget {
  const particularComment({
    Key? key,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
  }) : super(key: key);

  final String name;
  final String gender;
  final String dateOfBirth;

  @override
  State<particularComment> createState() => _particularCommentState();
}

class _particularCommentState extends State<particularComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
        title: Text("Comment"),
      ),
    );
  }
}
