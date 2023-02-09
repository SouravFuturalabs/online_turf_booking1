import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:online_turf_booking/screens/customer/customerHomeScreen.dart';
import 'package:online_turf_booking/screens/loginscreen.dart';
import 'package:online_turf_booking/screens/owner/ownerHomeScreen.dart';
import 'package:online_turf_booking/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var type = await sharedPreferences.getString("type") ?? "null";
  runApp(MyApp(
    type: type!,
  ));
}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
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
