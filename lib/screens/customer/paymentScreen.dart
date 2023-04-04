import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/screens/customer/customerHomeScreen.dart';

import '../../utilites/appconstants.dart';

class PaymentScreen extends StatefulWidget {
  String bookingid;
  String cardname;
  String amount;
  PaymentScreen(
      {Key? key,
      required this.bookingid,
      required this.cardname,
      required this.amount})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  dateselecting() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date!);
    setState(() {
      expdateController.text = formatted;
    });
  }

  /// bookingconfirmed

  bookingconfirm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Booking Confirmed"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (ctx) => PaymentScreen()));
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
                        "Print recept",
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
                   Navigator.of(context).pop;
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
              ],
            ),
          ),
        );
      },
    );
  }

  TextEditingController cardnumberController = TextEditingController();
  TextEditingController expdateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController holdernamecontroller = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final forkey = GlobalKey<FormState>();
  getdata() {
    setState(() {
      amountController.text = widget.amount;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: forkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Enter the payment details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cardnumberController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter card number";
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                          hintText: "Card number",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: TextFormField(
                              controller: expdateController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter expire date";
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
                                  errorStyle: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppConstants.primarycolors,
                                        width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppConstants.primarycolors,
                                        width: 2),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppConstants.primarycolors,
                                        width: 2),
                                  ),
                                  hintText: "Expire date",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: cvvController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter CVV";
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppConstants.primarycolors,
                                      width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppConstants.primarycolors,
                                      width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppConstants.primarycolors,
                                      width: 2),
                                ),
                                hintText: "CVV",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: holdernamecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter card holder name";
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
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
                          hintText: "Card holder name",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: amountController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter amount";
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      readOnly: true,
                      decoration: InputDecoration(
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
                          hintText: "Amount",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: InkWell(
                          onTap: () async {
                            final validate = forkey.currentState!.validate();

                            if (validate == true) {
                              var response = await Service().payment(
                                  widget.bookingid,
                                  widget.cardname,
                                  cardnumberController.text,
                                  expdateController.text,
                                  cvvController.text,
                                  holdernamecontroller.text,
                                  widget.amount);
                              if (response["message"] == "sucess") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Payment sucessfull")));
                                Navigator.of(context).pushAndRemoveUntil(
                                  // the new route
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CustomerHomeScreen(),
                                  ),

                                  (Route route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Somthing went wrong")));
                              }
                            }
                            // bookingconfirm();
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
                                "Pay now",
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
          ),
        ),
      ),
    );
  }
}
