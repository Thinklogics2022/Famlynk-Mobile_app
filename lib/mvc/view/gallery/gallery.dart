import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Image.network("https://images.pexels.com/photos/16010177/pexels-photo-16010177/free-photo-of-city-streets-sky-sunset.jpeg?auto=compress&cs=tinysrgb&w=400"),
                Image.network("https://images.pexels.com/photos/4792088/pexels-photo-4792088.jpeg?auto=compress&cs=tinysrgb&w=400")
              ]),
            )));
  }
}
