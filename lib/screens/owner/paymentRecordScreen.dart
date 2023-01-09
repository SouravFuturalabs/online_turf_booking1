

import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';

class PaymentRecordScreen extends StatefulWidget {
  const PaymentRecordScreen({Key? key}) : super(key: key);

  @override
  State<PaymentRecordScreen> createState() => _PaymentRecordScreenState();
}

class _PaymentRecordScreenState extends State<PaymentRecordScreen> {
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
                  "Payment Records",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Service().paymenthistory(),
                  builder: (context,sapshot) {
                    if (sapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppConstants.primarycolors,
                        ),
                      );
                    }
                    if(sapshot.hasData){
                      return ListView.builder(itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppConstants.primarycolors, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("payment 1"),
                            ),
                          ),
                        );
                      }); 
                    }else{
                      return Center(
                        child: Text("No payment history"),
                      );
                    }
                    
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
