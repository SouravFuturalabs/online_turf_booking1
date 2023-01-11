

import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';

class ViewFeedBackScreen extends StatefulWidget {
  const ViewFeedBackScreen({Key? key}) : super(key: key);

  @override
  State<ViewFeedBackScreen> createState() => _ViewFeedBackScreenState();
}

class _ViewFeedBackScreenState extends State<ViewFeedBackScreen> {
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
                  "Feedback",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: Service().viewFeedback(),
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        snapshot.data[index]["Feedback"]),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text("No FeedBack"),
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
