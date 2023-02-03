import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/apis.dart';
import '../../utilites/appconstants.dart';

class BookedSingleTurfDetails extends StatefulWidget {
  String id;
  String tym;
  String date;
  BookedSingleTurfDetails(
      {Key? key, required this.id, required this.date, required this.tym})
      : super(key: key);

  @override
  State<BookedSingleTurfDetails> createState() =>
      _BookedSingleTurfDetailsState();
}

class _BookedSingleTurfDetailsState extends State<BookedSingleTurfDetails> {
  String? url;
  getdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    url = await sharedPreferences.getString("url");

    // id = await sharedPreferences.getString("id");
    // email = await sharedPreferences.getString("email");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FutureBuilder(
            future: Service().getSingleTurfDetails(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppConstants.primarycolors,
                  ),
                );
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data["Turf_name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: AppConstants.boldText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "${url!.split("API/").first.toString()}Img/${snapshot.data["image"]}"))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.red,
                          ),
                          Text(
                            snapshot.data["Turf_location"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Contact :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data["owner_ph"],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                // Text("9657455884",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "email : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${snapshot.data["Owner_email"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     left: 8.0,
                    //     top: 8,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //
                    //       Text(
                    //         "Rating : ",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 20,
                    //             color: Colors.black),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       Text("*****",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                    //
                    //     ],
                    //
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Address : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            snapshot.data["Turf_location"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "BookedDate : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            widget.date,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Time : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            " ${widget.tym.toString().split(" ").first} to ${widget.tym.toString().split(" ").last}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text("Something went wrong");
              }
            }),
      )),
    );
  }
}
