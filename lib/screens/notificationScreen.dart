import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../utilites/appconstants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                  "Notifications",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: Service().getNotification(),
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
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0,right: 8,top:8),
                                        child: Row(children: [
                                          Text("Tutf : "),
                                          Text(snapshot.data[index]["Turf_name"])
                                        ],),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.only(left:8.0,right: 8),
                                        child: Row(children: [
                                          Text("phone : "),
                                          Text(snapshot.data[index]["owner_ph"])
                                        ],),
                                      ),
                                       Padding(
                                        padding: const EdgeInsets.only(left:8.0,right: 8),
                                        child: Row(children: [
                                          Text("Location : "),
                                          Text(snapshot.data[index]["Turf_location"])
                                        ],),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0,right: 8),
                                        child: Row(
                                          children: [
                                            Text("Notification"),
                                          ],
                                        ),
                                      ),
                                      
                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0,right: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                                snapshot.data[index]["Notification"]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text("No Notification"),
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
