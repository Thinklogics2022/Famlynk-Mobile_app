import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WhatsApp whatsapp = WhatsApp();
  int phoneNumber = 6384886472;
  @override
  void initState() {
    whatsapp.setup(
      accessToken: "YOUR_ACCESS_TOKEN_HERE",
      fromNumberId: 000000000000000,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesText(
                to: phoneNumber,
                message: "Hello Flutter",
                previewUrl: true,
              ));
            },
            child: const Text("Send Message"),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Message extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => _launchWhatsApp(),
//           child: Text('Open WhatsApp'),
//         ),
//       ),
//     );
//   }

//   void _launchWhatsApp() async {
//     final phoneNumber = 6384886472;
//     final message = 'Hello, this is a WhatsApp message!';

//     final whatsappUrl = 'https://wa.me/$phoneNumber/?text=${Uri.encodeFull(message)}';

//     if (await canLaunch(whatsappUrl)) {
//       await launch(whatsappUrl);
//     } else {
//       throw 'Could not launch $whatsappUrl';
//     }
//   }
// }

 
