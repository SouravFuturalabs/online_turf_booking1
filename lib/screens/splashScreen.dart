import 'package:flutter/material.dart';

import 'customer/customerHomeScreen.dart';
import 'loginscreen.dart';
import 'owner/ownerHomeScreen.dart';

class SplashScreen extends StatefulWidget {
  String Type;
  SplashScreen({Key? key, required this.Type}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToPages() async {
    await Future.delayed(Duration(seconds: 2));

    if (widget.Type == "customer") {
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => CustomerHomeScreen(),
        ),

        (Route route) => false,
      );
    }
    if (widget.Type == "turf") {
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => OwnerHomeScreen(),
        ),

        (Route route) => false,
      );
    }

    if (widget.Type == "null") {
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),

        (Route route) => false,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
     goToPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.height/2.5,
              child: Image.asset("assets/logo.jpg")),//Image.asset("assets/logo.jpg")
        ),
      ),
    );
  }
}
