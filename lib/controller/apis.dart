import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../screens/customer/customerHomeScreen.dart';

class Apis {
  final url = "http://192.168.29.86/OnlineTurffManagement/API/";

  customerReg(String name, address, dob, phone, email, password,
      BuildContext context) async {
    var body = {
      "Cname": name,
      "Caddress": address,
      "Cdob": dob,
      "CPhone_no": phone,
      "CEmail": email,
      "CPassword": password
    };
    //  print(body);
    var response = await post(Uri.parse("${url}customer_reg.php"), body: body);

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => CustomerHomeScreen(),
        ),

        (Route route) => false,
      );
    }
  }

  // var request = http.MultipartRequest("POST", Uri.parse(urls));
  // request.fields["latitude"] = lati.toString();
  // request.fields["longitude"] = long.toString();
  // request.fields["employee"] = id.toString();
  // request.files.add(http.MultipartFile.fromBytes(
  // "photo", File(file!.path).readAsBytesSync(),
  // filename: file!.path));
  // request.fields["date"] = date.toString();
  // request.fields["time"] = timess.toString();
  // var res = await request.send();
}
