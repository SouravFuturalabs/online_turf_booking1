import 'package:flutter/material.dart';
import 'package:online_turf_booking/utilites/appconstants.dart';

import 'bookingScreen.dart';

class SingleTurfDetails extends StatefulWidget {
  const SingleTurfDetails({Key? key}) : super(key: key);

  @override
  State<SingleTurfDetails> createState() => _SingleTurfDetailsState();
}

class _SingleTurfDetailsState extends State<SingleTurfDetails> {
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
                "Turf Name",
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
                            "https://5.imimg.com/data5/UF/VO/WA/SELLER-2751211/fifa-certified-artificial-football-grass-500x500.jpg"))),
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
                    "Location",
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
                        Text("9966554436",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                        Text("9657455884",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400))
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
                  Text("werty@gmail.com",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),

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
                    "Rating : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Text("*****",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),

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
                    "Address : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  Text("Turf, sivil station",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingScreen(),));
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
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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
        ),
      )),
    );
  }
}
