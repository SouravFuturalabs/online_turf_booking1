import 'package:flutter/material.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';

class MybookingScreen extends StatefulWidget {
  const MybookingScreen({Key? key}) : super(key: key);

  @override
  State<MybookingScreen> createState() => _MybookingScreenState();
}

class _MybookingScreenState extends State<MybookingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My booking",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppConstants.primarycolors, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("Turf Name"),
                                    Text("Date"),
                                    Text("Time")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1.0),
                                      child: InkWell(
                                        onTap: (){
                                          // final valid = formKey.currentState!.validate();

                                        },
                                        child: Container(
                                          height: 30,
                                          width: 90,
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
                                              "View",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18.0),
                                      child: InkWell(
                                        onTap: (){
                                          // final valid = formKey.currentState!.validate();

                                        },
                                        child: Container(
                                          height: 30,
                                          width: 90,
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
                                              "Cancel",
                                              style: TextStyle(
                                                fontSize: 14,
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
                              )
                            ],
                          )

                        ),
                      );
                    }
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
