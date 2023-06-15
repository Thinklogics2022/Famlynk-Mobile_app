import 'package:famlynk_version1/constants/constVariables.dart';
import 'package:flutter/material.dart';

class FamilyList extends StatefulWidget {
  const FamilyList({super.key});

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  MyProperties myProperties = new MyProperties();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              color: const Color.fromARGB(255, 189, 192, 193),
              shadowColor: Colors.blueGrey,
              elevation: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                          'https://www.newidea.com.au/media/104672/untitled-design-16.jpg?width=720&center=0.0,0.0'),
                      title: Text('Pandiiii',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('Brother', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              color: const Color.fromARGB(255, 189, 192, 193),
              shadowColor: Colors.blueGrey,
              elevation: 6,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                          'https://www.whatsappimages.in/wp-content/uploads/2022/08/aesthetic-girl-wallpaper.jpg'),
                      title: Text('Sneha',
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('Friend', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
