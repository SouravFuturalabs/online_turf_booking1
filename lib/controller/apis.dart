import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/customer/customerHomeScreen.dart';
import '../screens/owner/ownerHomeScreen.dart';

class Apis {
  final url = "http://192.168.29.86/OnlineTurffManagement/API/";

  login(String username, password, BuildContext context) async {
    var body = {"uname": username, "password": password};
    var response = await post(Uri.parse("${url}login.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);

      if (rbody["message"] == "sucess") {
        if (rbody["type"] == "customer") {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("id", rbody["Cid"]);
          sharedPreferences.setString("name", rbody["Cname"]);
          sharedPreferences.setString("email", rbody["CEmail"]);
          sharedPreferences.setString("type", rbody["type"]);
          Navigator.of(context).pushAndRemoveUntil(
            // the new route
            MaterialPageRoute(
              builder: (BuildContext context) => CustomerHomeScreen(),
            ),

            (Route route) => false,
          );
        } else if (rbody["type"] == "turf") {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("id", rbody["Turf_id"]);
          sharedPreferences.setString("name", rbody["Turf_name"]);
          sharedPreferences.setString("email", rbody["Owner_email"]);
          sharedPreferences.setString("type", rbody["type"]);
          Navigator.of(context).pushAndRemoveUntil(
            // the new route
            MaterialPageRoute(
              builder: (BuildContext context) => OwnerHomeScreen(),
            ),

            (Route route) => false,
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("username or password not valid")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Somthing went wrong please try again")));
    }
  }

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
      var rbody = jsonDecode(response.body);

      if (rbody["Cid"].isNotEmpty) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("id", rbody["Cid"]);
        sharedPreferences.setString("name", rbody["Cname"]);
        sharedPreferences.setString("email", rbody["CEmail"]);
        sharedPreferences.setString("type", rbody["user_type"]);

        print(response.body);
        Navigator.of(context).pushAndRemoveUntil(
          // the new route
          MaterialPageRoute(
            builder: (BuildContext context) => CustomerHomeScreen(),
          ),

          (Route route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Somthing went wrong please try again")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Somthing went wrong please try again")));
    }
  }

  turfReg(String tname, tlocation, accountnum, ownername, File image,
      String email, String phone, File licphoto,String password)async {
    final fullurl = "${url}turf_reg.php";
    var request = MultipartRequest("POST", Uri.parse(fullurl));
    request.fields["Turf_name"] = tname;
    request.fields["Turf_location"] = tlocation;
    request.fields["owner_acc"] = accountnum;
    request.fields["owner_name"] = ownername;
    request.files.add(MultipartFile.fromBytes(
        "image", File(image!.path).readAsBytesSync(),
        filename: image!.path));
    request.fields["Owner_email"] = email;
    request.fields['owner_ph'] = phone;
    request.files.add(MultipartFile.fromBytes(
        "licence", File(licphoto.path).readAsBytesSync(),
        filename: licphoto.path));
    request.fields['password'] = password;

    var response =await request.send();


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
