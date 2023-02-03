import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/screens/customer/viewBookedSingleTurfDetails.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';

import 'singleTurfDetails.dart';

class MybookingScreen extends StatefulWidget {
  const MybookingScreen({Key? key}) : super(key: key);

  @override
  State<MybookingScreen> createState() => _MybookingScreenState();
}

class _MybookingScreenState extends State<MybookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: FutureBuilder(
                    future: Service().viewMyBooking(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppConstants.primarycolors,
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppConstants.primarycolors,
                                            width: 2)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                  "Turf Name : ${snapshot.data[index]["Turf_name"]}"),
                                              Text(
                                                  "Date : ${snapshot.data[index]["bdate"]}"),
                                              Text(
                                                  "Time : ${snapshot.data[index]["time_slot"].toString().split(" ").first} to ${snapshot.data[index]["time_slot"].toString().split(" ").last}"),
                                              Text(
                                                  "BookStatus : ${snapshot.data[index]["Book_status"]}"),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookedSingleTurfDetails(id: snapshot.data[index]["Turf_id"],tym: snapshot.data[index]["time_slot"].toString(),date:snapshot.data[index]["bdate"] ,),));
                                                    // final valid = formKey.currentState!.validate();
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .primarycolors,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(4, 4),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                      child: Text(
                                                        "View",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18.0),
                                                child: InkWell(
                                                  onTap: ()async {
                                                  var response = await  Service().cancelbooking(snapshot.data[index]["Book_id"]);
                                                  if(response["message"] == "sucess"){
                                                    setState(() {

                                                    });
                                                  }else{
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Somthing went wrong")));
                                                  }
                                                    // final valid = formKey.currentState!.validate();
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                        color: AppConstants
                                                            .primarycolors,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset:
                                                                Offset(4, 4),
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Center(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                    )),
                              );
                            });
                      } else {
                        return Center(
                          child: Text("no booking "),
                        );
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
