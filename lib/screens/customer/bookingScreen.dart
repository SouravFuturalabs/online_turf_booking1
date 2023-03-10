import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';
import 'paymentScreen.dart';

class BookingScreen extends StatefulWidget {
  String rate;
  String id;
  BookingScreen({Key? key, required this.rate, required this.id})
      : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  ///while clicking confirm
  choosePaymentmode(String bookingid,amount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter the payment mode"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PaymentScreen(
                              bookingid: bookingid,
                              cardname: "Credit Card",
                          amount: amount,
                            )));
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
                        "Credit Card",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => PaymentScreen(
                              bookingid: bookingid,
                              cardname: "Debit Card",
                          amount: amount,
                            )));
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (ctx) => OwnerReqScreen()));
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
                        "Debit Card",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String? _fromtime;
  TimeOfDay? fromTimeOfDay;
  fromtime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      _fromtime = time.toString().substring(10, 15);
      fromTimeOfDay = time;
    });
  }

  String? _totime;
  TimeOfDay? toTimeInTimeOfDay;
  totime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    setState(() {
      _totime = time.toString().substring(10, 15);
      toTimeInTimeOfDay = time;
    });
  }

  dateselecting() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date!);
    setState(() {
      dateController.text = formatted;
    });
  }

  int bookingfor = -1;
  String? bookingforname;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Fill the details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                  textAlign: TextAlign.center,
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
                      "Rate per hour : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.rate.toString(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the date of boking";
                    }
                  },
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                  readOnly: true,
                  onTap: () {
                    dateselecting();
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.date_range_rounded,
                        color: AppConstants.primarycolors,
                      ),
                      errorStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
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
                      hintText: "Date of booking",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Book for",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: bookingfor,
                                  onChanged: (v) {
                                    setState(() {
                                      bookingfor = v!;
                                    });
                                  }),
                              Text(
                                "Single day",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: bookingfor,
                                  onChanged: (v) {
                                    setState(() {
                                      bookingfor = v!;
                                    });
                                  }),
                              Text(
                                "Week        ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 3,
                                  groupValue: bookingfor,
                                  onChanged: (v) {
                                    setState(() {
                                      bookingfor = v!;
                                    });
                                  }),
                              Text(
                                "Month      ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Radio(value: 1, groupValue: 1, onChanged: (v){}),
                          //     Text(
                          //       "Single day",
                          //       style:
                          //       TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                          //     ),
                          //   ],
                          // )
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppConstants.primarycolors, width: 2)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        fromtime();
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        child: Center(
                            child: Text(
                          _fromtime == null
                              ? "From time"
                              : _fromtime.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppConstants.primarycolors, width: 2)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        totime();
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        child: Center(
                            child: Text(
                          _totime == null ? "To time" : _totime.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppConstants.primarycolors, width: 2)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: InkWell(
                      onTap: () async {
                        print(_fromtime);


                        if (dateController.text.isNotEmpty &&
                            _fromtime!.isNotEmpty &&
                            _totime!.isNotEmpty &&
                            bookingfor != -1) {
                          var nowSec = (fromTimeOfDay!.hour * 60 + fromTimeOfDay!.minute) * 60;
                          var veiSec = (toTimeInTimeOfDay!.hour * 60 + toTimeInTimeOfDay!.minute) * 60;
                          var dif = veiSec - nowSec;
                          int diffInInt = dif.toInt();
                          int convertIntoMint = (diffInInt/60).toInt();
                          double hours = convertIntoMint/60;
                          var rate = int.parse(widget.rate.toString()).toInt();
                          var amount = rate*hours;

                          print(" amount ${amount}");

                          print(convertIntoMint);
                          if(convertIntoMint>=60){
                            if (bookingfor == 1) {
                              setState(() {
                                bookingforname = "single day";
                              });
                            }
                            if (bookingfor == 2) {
                              setState(() {
                                bookingforname = "week";
                                amount = rate*hours*7;
                              });
                            }
                            if (bookingfor == 3) {
                              setState(() {
                                bookingforname = "month";
                                amount = rate*hours*30;
                              });
                            }
                            var data = await  Service().bookturf(
                                widget.id,
                                dateController.text,
                                "pending",
                                "${_fromtime} ${_totime}",
                                bookingforname);

                            if(data !=null){
                              print(data);
                              // choosePaymentmode(data);
                              choosePaymentmode(data,amount.toString());
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Must book for one hours")));
                          }



                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("please fill all the details")));
                        }

                        // if (dateController.text.isEmpty &&
                        //     _fromtime == null &&
                        //     _totime == null &&
                        //     bookingfor == -1) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       content: Text("please fill all the details")));
                        // } else {
                        //   if (bookingfor == 1) {
                        //     setState(() {
                        //       bookingforname = "single day";
                        //     });
                        //   }
                        //   if (bookingfor == 2) {
                        //     setState(() {
                        //       bookingforname = "week";
                        //     });
                        //   }
                        //   if (bookingfor == 3) {
                        //     setState(() {
                        //       bookingforname = "month";
                        //     });
                        //   }
                        //
                        // var data = await  Service().bookturf(
                        //        widget.id,
                        //        dateController.text,
                        //        "pending",
                        //        "${_fromtime} ${_totime}",
                        //        bookingforname);
                        //
                        //   if(data !=null){
                        //     print(data);
                        //    // choosePaymentmode(data);
                        //     choosePaymentmode(data);
                        //   }
                        // }
                        // choosePaymentmode();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingScreen(),));
                      },
                      child: Container(
                        height: 40,
                        width: 130,
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
                            "Confirm",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: InkWell(
                      onTap: () {
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BookingScreen(),));
                      },
                      child: Container(
                        height: 40,
                        width: 130,
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
                            "Cancel",
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
            ],
          ),
        ),
      )),
    );
  }
}
