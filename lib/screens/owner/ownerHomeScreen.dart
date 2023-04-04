import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/screens/notificationScreen.dart';
import 'package:online_turf_booking/screens/owner/turfBookHistoryScreen.dart';
import 'package:online_turf_booking/screens/owner/viewFeedbackScreen.dart';
import 'package:online_turf_booking/screens/settingsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilites/appconstants.dart';
import '../loginscreen.dart';
import 'addnotificationScreen.dart';
import '../customer/editprofileScreen.dart';
import 'editprofileOwnerScreen.dart';
import 'paymentRecordScreen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({Key? key}) : super(key: key);

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  String? type;
  String? name;
  String? id;
  String? email;
  String? fnamelatter;
  String? url;
  getdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // var id = await sharedPreferences.getString("id");

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
    getTurfdeails();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getdetails();
    
    super.initState();
  }

  bool turfAvilableStatus=false;

  getTurfdeails()async{
    var response =await  Service().getSingleTurfDetails(id!);
    if(response["truf_available"]== "true"){
      setState(() {
        turfAvilableStatus = true;
      });
    }
    else{
      setState(() {
        turfAvilableStatus = false;
      });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppConstants.primarycolors,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppConstants.primarycolors),
                accountName: Text(
                  name ?? "loading",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email ?? "loading"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    fnamelatter ?? "",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            Card(
              child: ListTile(
                title: Text("profile"),
                trailing: Icon(Icons.account_circle),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfileOnwerScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Maintenance"),
                trailing: Switch(
                  onChanged: (value)async {
                    if( turfAvilableStatus == true){
                   var response =  await Service().chnageTurfStatus(id!, "false");
                   print(">>>>>>>>>___${response}");
                   if(response["message"]=="sucess"){
                    getTurfdeails();
                    // setState(() {
                    //   turfAvilableStatus == false;
                    // });
                   }

                    }
                      if( turfAvilableStatus == false){
                   var response =  await Service().chnageTurfStatus(id!, "true");
                    if(response["message"]=="sucess"){
                      getTurfdeails();
                    // setState(() {
                    //   turfAvilableStatus == true;
                    // });
                   }

                    }




                  },
                  value: turfAvilableStatus,
                  activeColor: AppConstants.primarycolors,
                ),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MybookingScreen(),));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Add Notification"),
                trailing: Icon(Icons.add),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddNotificationScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("View feedback"),
                trailing: Icon(Icons.feedback),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewFeedBackScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Payment"),
                trailing: Icon(Icons.payments),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentRecordScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("History"),
                trailing: Icon(Icons.history),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TurfHistoryScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
                onTap: () async {
                  SharedPreferences sharefp =
                      await SharedPreferences.getInstance();
                  await sharefp.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),

                    (Route route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: AppConstants.boldText),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder(
                  future: Service().getSingleTurfDetails(id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppConstants.primarycolors,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${url!.split("API/").first.toString()}Img/${snapshot.data["image"]}"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                  color: AppConstants.primarycolors, width: 2)),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/truf.png"),
                                  fit: BoxFit.cover),
                              border: Border.all(
                                  color: AppConstants.primarycolors, width: 2)),
                        ),
                      );
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Requests",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: AppConstants.boldText),
                  textAlign: TextAlign.center,
                ),
              ),
              FutureBuilder(
                  future: Service().allRequest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppConstants.primarycolors,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
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
                                                  Text("Time :")
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
                                                      "${snapshot.data[index]["time_slot"].toString().split(" ").first} to ${snapshot.data[index]["time_slot"].toString().split(" ").last}")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 1.0),
                                                child: InkWell(
                                                  onTap: () async {
                                                    var response =
                                                        await Service()
                                                            .acceptOrReject(
                                                                snapshot.data[
                                                                        index]
                                                                    ["Book_id"],
                                                                "approve");

                                                    if (response["message"] ==
                                                        "sucess") {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Approved")));
                                                      setState(() {});
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
                                                        "Accept",
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
                                                  onTap: () async {
                                                    var response =
                                                        await Service()
                                                            .acceptOrReject(
                                                                snapshot.data[
                                                                        index]
                                                                    ["Book_id"],
                                                                "reject");

                                                    if (response["message"] ==
                                                        "sucess") {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Rejected")));
                                                      setState(() {});
                                                    }
                                                    // final valid = formKey.currentState!.validate();
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
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
                                                        "Reject",
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
                            }),
                      );
                    } else {
                      return Center(
                        child: Text("No Request"),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
