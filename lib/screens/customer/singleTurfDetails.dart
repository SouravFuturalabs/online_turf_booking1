import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookingScreen.dart';

class SingleTurfDetails extends StatefulWidget {
  String id;
  SingleTurfDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<SingleTurfDetails> createState() => _SingleTurfDetailsState();
}

class _SingleTurfDetailsState extends State<SingleTurfDetails> {
  String? type;
  String? name;
  String? id;
  String? email;
  String? fnamelatter;
  String? url;
  getdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    type = await sharedPreferences.getString("type");
    name = await sharedPreferences.getString("name");
    url = await sharedPreferences.getString("url");
    if (name!.length >= 3) {
      fnamelatter = name!.substring(0, 1).toString();
    } else {
      fnamelatter = "";
    }

    id = await sharedPreferences.getString("id");
    email = await sharedPreferences.getString("email");
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
                      padding: const EdgeInsets.only(top: 18.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BookingScreen(rate: snapshot.data["rate"],id: snapshot.data["Turf_id"]),
                          ));
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
                              "Book",
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
                );
              } else {
                return Text("Something went wrong");
              }
            }),
      )),
    );
  }
}
