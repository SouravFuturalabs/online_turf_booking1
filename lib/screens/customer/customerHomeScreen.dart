import 'package:flutter/material.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';

import '../editprofileScreen.dart';
import 'feedbackScreen.dart';
import '../mybookingScreen.dart';
import '../notificationScreen.dart';
import '../settingsScreen.dart';
import 'singleTurfDetails.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
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
                  "Abhishek Mishra",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("abhishekm977@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ),
            Card(
              child: ListTile(
                title: Text("profile"),
                trailing: Icon(Icons.account_circle),
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen(),));

                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("My booking"),
                trailing: Icon(Icons.book),
                onTap: (){

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MybookingScreen(),));

                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Notification"),
                trailing: Icon(Icons.notifications),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen(),));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Feedback"),
                trailing: Icon(Icons.feedback),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
                onTap: (){

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    //controller: nameController,

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
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SingleTurfDetails(),
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
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                "https://5.imimg.com/data5/UF/VO/WA/SELLER-2751211/fifa-certified-artificial-football-grass-500x500.jpg"))),
                                  ),
                                ),
                              ),
                              Text(
                                "Kozhikode",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
