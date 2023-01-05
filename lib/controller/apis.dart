import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:online_turf_booking/screens/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/customer/customerHomeScreen.dart';
import '../screens/customer/editprofileScreen.dart';
import '../screens/owner/ownerHomeScreen.dart';

class Service {
  String url = "http://192.168.29.86/OnlineTurffManagement/API/";

  login(String username, password, BuildContext context) async {
    var body = {"uname": username, "password": password};
    var response = await post(Uri.parse("${url}login.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      print(rbody);

      if (rbody["message"] == "sucess") {
        if (rbody["type"] == "customer") {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("id", rbody["Cid"]);
          sharedPreferences.setString("name", rbody["Cname"]);
          sharedPreferences.setString("email", rbody["CEmail"]);
          sharedPreferences.setString("type", rbody["type"]);
          sharedPreferences.setString("url", url);
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
          sharedPreferences.setString("url", url);
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
            SnackBar(content: Text("Somthing went wrong please try again")));
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
        sharedPreferences.setString("url", url);

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

  turfReg(
      String tname,
      tlocation,
      accountnum,
      ownername,
      File image,
      String email,
      String phone,
      File licphoto,
      String password,
      String rateperhours,
      BuildContext context) async {
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
    request.fields['rate'] = rateperhours;

    //var response =await request.send();
    request.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded!");
        final data = await Response.fromStream(response);

        var rbody = jsonDecode(data.body);
        if (rbody["message"] == "sucess") {
          print(data.body);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("id", rbody["Turf_id"]);
          sharedPreferences.setString("name", rbody["Turf_name"]);
          sharedPreferences.setString("email", rbody["Owner_email"]);
          sharedPreferences.setString("type", rbody["user_type"]);
          sharedPreferences.setString("url", url);
          Navigator.of(context).pushAndRemoveUntil(
            // the new route
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
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
    });
  }

  Future<dynamic> getfullturfdeatils() async {
    var response = await get(Uri.parse("${url}view_turf.php"));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);

      if (body[0]["message"] == null) {
        print(body);
        return body;
      }
    }
  }

  Future<dynamic> getSingleTurfDetails(String id) async {
    var body = {"Turf_id": id};
    var response = await post(Uri.parse("${url}view_turfid.php"), body: body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      return body;
    }
  }

  Future<dynamic> getCustomerdetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    print(id);

    var body = {"Cid": id};
    var response = await post(Uri.parse("${url}view_custid.php"), body: body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(body);
      return body;
    }
  }

  Future<dynamic> updatecustomerprofile(String name, email, oldemail, dob,
      addresss, passord, phone, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    print(id);
    var body = {
      "Cid": id,
      "Cname": name,
      "CEmail": "hj",
      "Caddress": addresss,
      "Cdob": dob,
      "CPhone_no": phone,
      "newemail": email,
      "password": passord
    };

    //print(body);

    var response = await post(Uri.parse("${url}update_cust.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      if (rbody["message"] == "sucess") {
        print(response.body);
        sharedPreferences.setString("name", rbody["Cname"]);
        sharedPreferences.setString("email", rbody["CEmail"]);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Profile Updated")));
        return rbody["message"];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Somthing went wrong please try again")));
      }
    }
  }

  addnotification(String notification,BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    print(id);
    var body = {"Turf_id": id, "Notification": notification};
    var response = await post(Uri.parse("${url}ins_notification.php"), body: body);
    if(response.statusCode ==200){
      var rbody=jsonDecode(response.body);
      if(rbody["message"]=="sucess"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Notification added!!")));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Somthing went wrong please try again")));
      }


    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Somthing went wrong please try again")));
    }
  }
}
