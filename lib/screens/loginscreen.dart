import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';

import 'customer/customerRegScreen.dart';
import 'owner/ownerReqScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// while clicking signup
  customerOrowner() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Register as"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CustomerRegScreen()));
                  },
                  child: Container(
                    height: 40,
                    width: 190,
                    decoration: BoxDecoration(
                        color: AppConstants.primarycolors,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                            blurRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "Customer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => OwnerReqScreen()));
                  },
                  child: Container(
                    height: 40,
                    width: 190,
                    decoration: BoxDecoration(
                        color: AppConstants.primarycolors,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                            blurRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Center(
                      child: Text(
                        "Turf owner",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to online \n Turf",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the username";
                      }
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        hintText: "User Name",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: isPasswordVisible,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the Password";
                      }
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppConstants.primarycolors, width: 2),
                        ),
                        suffixIcon: isPasswordVisible == true
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = false;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = true;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: InkWell(
                    onTap: () {
                      final valid = formKey.currentState!.validate();
                      if (valid == true) {
                        Service().login(nameController.text,
                            passwordController.text, context);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 190,
                      decoration: BoxDecoration(
                          color: AppConstants.primarycolors,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(4, 4),
                              spreadRadius: 1,
                              blurRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an Account ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              customerOrowner();
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
