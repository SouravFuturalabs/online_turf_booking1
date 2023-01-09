import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';

class TurfHistoryScreen extends StatefulWidget {
  const TurfHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TurfHistoryScreen> createState() => _TurfHistoryScreenState();
}

class _TurfHistoryScreenState extends State<TurfHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "History",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: Service().history(),
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
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,

                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8, left: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Customer : "),
                                                Text("Date :"),
                                                Text("Time :"),
                                                Text("Booking Status : ")
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    "${snapshot.data[index]["Cname"]}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Text(
                                                    "${snapshot.data[index]["bdate"]}"),
                                                Text(
                                                    "${snapshot.data[index]["time_slot"].toString().split(" ").first} to ${snapshot.data[index]["time_slot"].toString().split(" ").last}"),
                                                Text(
                                                    "${snapshot.data[index]["Book_status"]}"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  )),
                            );
                          });
                    } else {
                      return Center(
                        child: Text("No Request"),
                      );
                    }
                  }),
            ),
          ],
        )
      ),
    );
  }
}
