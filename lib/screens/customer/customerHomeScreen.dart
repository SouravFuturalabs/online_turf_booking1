import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/screens/loginscreen.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofileScreen.dart';
import 'feedbackScreen.dart';
import 'mybookingScreen.dart';
import '../notificationScreen.dart';
import '../settingsScreen.dart';
import 'singleTurfDetails.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  String? url;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? type;
  String? name;
  String? id;
  String? email;
  String? fnamelatter;

  List searchedList =[];

  TextEditingController searchController = TextEditingController();
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
    print(id);
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        // automaticallyImplyLeading: false,
        // leading: InkWell(
        //   onTap: (){
        //     Scaffold.of(context).openDrawer();
        //     // if(_key.currentState!.isDrawerOpen){
        //     //   _key.currentState!.openEndDrawer();
        //     // }else{
        //     //   _key.currentState!.openDrawer();
        //     // }
        //   },
        //   child: Icon(
        //     Icons.menu,
        //     color: Colors.black,
        //   ),
        // ),
      ),
      drawer: Drawer(
        key: _key,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppConstants.primarycolors,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppConstants.primarycolors),
                accountName: Text(
                  name ?? "loading...",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(email ?? "loading..."),
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
                    builder: (context) => EditProfileScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("My booking"),
                trailing: Icon(Icons.book),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MybookingScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Notification"),
                trailing: Icon(Icons.notifications),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Feedback"),
                trailing: Icon(Icons.feedback),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FeedbackScreen(),
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
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings(),));
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
                  "Welcome to \n online Turf",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: AppConstants.boldText),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.4,

                        child: TextFormField(
                          controller: searchController,

                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.only(top: 5),
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
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 40,
                            //width: 190,
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
                                "Search",
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
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: Service().getfullturfdeatils(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppConstants.primarycolors,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      searchedList.clear();
                      snapshot.data.forEach((element){
                        if(element["Turf_name"].contains(searchController.text)){
                          searchedList.add(element);

                        }
                        print(element["Turf_name"]);
                        //print(searchedList);
                      });
                    // searchedList = snapshot.data.where((value)=> value["Turf_name"].contain(searchController.text)).toList();
                    print(" searchde  ${searchedList}");
                      return searchController.text.isEmpty ? Expanded(
                        child: GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SingleTurfDetails(
                                      id: snapshot.data[index]["Turf_id"]
                                          .toString(),
                                    ),
                                  ));
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "${url!.split("API/").first.toString()}Img/${snapshot.data[index]["image"]}"))),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index]["Turf_name"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ): Expanded(
                        child: GridView.builder(
                            itemCount: searchedList.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                            itemBuilder: (context, index) {

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SingleTurfDetails(
                                      id: searchedList[index]["Turf_id"]
                                          .toString(),
                                    ),
                                  ));
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "${url!.split("API/").first.toString()}Img/${searchedList[index]["image"]}"))),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        searchedList[index]["Turf_name"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Text("No Turf Available"),
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
