import 'package:famlynk_version1/mvc/view/famlynkLogin/login/EmailLogin.dart';
import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LogOutPage extends StatefulWidget {
  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "LogOut",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: HexColor('#0175C8'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          ScaleTransition(
                            scale: _animation,
                            child: Image.asset(
                              'assets/images/FL01.png',
                              width: 150,
                              height: 150,
                            ),
                          ),
                          SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(
                                      'Are you sure want to logout',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                              )),
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => NavBar(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.blue,
                                              textStyle: TextStyle(
                                                fontSize: 18,
                                              )),
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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












// import 'package:famlynk_version1/constants/constVariables.dart';
// import 'package:famlynk_version1/mvc/view/famlynkLogin/login/EmailLogin.dart';
// import 'package:famlynk_version1/mvc/view/navigationBar/navBar.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FamlynkLogout extends StatefulWidget {
//   @override
//   _FamlynkLogoutState createState() => _FamlynkLogoutState();
// }

// class _FamlynkLogoutState extends State<FamlynkLogout> {
//   late SharedPreferences logindata;
//   late String username;

//   @override
//   void initState() {
//     super.initState();
//     initial();
//   }

//   void initial() async {
//     logindata = await SharedPreferences.getInstance();
//     setState(() {
//       username = logindata.getString('username')!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     MyProperties myProperties = MyProperties();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign-Out"),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(30),
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color.fromARGB(255, 129, 129, 129).withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       'Are you sure you want to logout?',
//                       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 20, right: 60, top: 10),
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: myProperties.buttonColor,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => LoginPage()),
//                             );
//                           },
//                           child: Text('Yes'),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: myProperties.buttonColor,
//                           ),
//                           onPressed: () async {
//                             await logindata.setBool('isLoggedIn', false);
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (context) => NavBar()),
//                             );
//                           },
//                           child: Text('No'),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
