import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController notificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add offical notification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: notificationController,
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter official notification";
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
                          hintText: "official notification",
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
                          Service().addnotification(
                              notificationController.text, context);
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Submit",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
