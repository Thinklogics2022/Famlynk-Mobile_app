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
                                        0, 3), 
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
                                            Navigator.pushReplacement(
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
