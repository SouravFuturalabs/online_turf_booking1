import 'package:flutter/material.dart';
import 'package:online_turf_booking/screens/customer/customerHomeScreen.dart';
import 'package:online_turf_booking/screens/loginscreen.dart';
import 'package:online_turf_booking/screens/owner/ownerHomeScreen.dart';
import 'package:online_turf_booking/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var type = await sharedPreferences.getString("type") ?? "null";
  runApp(MyApp(
    type: type!,
  ));
}

class MyApp extends StatelessWidget {
  String type;
  MyApp({super.key, required this.type});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: type == "customer"
          ? SplashScreen(Type: "customer",)
          : type == "turf"
              ? SplashScreen(Type: "turf",)
              : type == "null"
                  ? SplashScreen(Type: "null",)
                  : LoginScreen(),
    );
  }
}
