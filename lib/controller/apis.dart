import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    EasyLoading.show(status: 'loading...');
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
    // request.files.add(MultipartFile.fromBytes(
    //     "licence", File(licphoto.path).readAsBytesSync(),
    //     filename: licphoto.path));
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

          ///------------------ lices
          final fullurl1 = "${url}turf_reg_image.php";
          var request1 = MultipartRequest("POST", Uri.parse(fullurl1));
          print( rbody["Turf_id"]);
          request1.fields["Turf_id"] = rbody["Turf_id"];
          request1.files.add(MultipartFile.fromBytes(
              "image", File(licphoto.path).readAsBytesSync(),
              filename: licphoto.path));

          request1.send().then((responsevalue)async {
            if(responsevalue.statusCode == 200){
              final data1 = await Response.fromStream(responsevalue);
              print(data1.body);

              var rbody1 = jsonDecode(data1.body);
              print(rbody1);

              if(rbody1["message"] == "sucess"){

                ///---------------------- eassy loading
                EasyLoading.dismiss();
                print("2 image Uploaded!");

                Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),

                      (Route route) => false,
                );
              }

            }
          });





        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Somthing went wrong please try again")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Somthing went wrong please try again")));
      }
    });

    EasyLoading.dismiss();
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
      "CEmail": oldemail,
      "Caddress": addresss,
      "Cdob": dob,
      "CPhone_no": phone,
      "newemail": email,
      "password": passord
    };

    print(" body of udate user email ${email}");
    print(" body of udate user address ${addresss}");
    print(" body of udate user email ${oldemail}");
    print(" body of udate user email ${passord}");
    print(" body of udate user email ${body}");

    var response = await post(Uri.parse("${url}update_cust.php"), body: body);
    if (response.statusCode == 200) {
      print(response.body);
      var rbody = jsonDecode(response.body);
      if (rbody["message"] == "sucess") {
        print(" resssponse    ----${response.body}");
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

  addnotification(String notification, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    print(id);
    var body = {"Turf_id": id, "Notification": notification};
    var response =
        await post(Uri.parse("${url}ins_notification.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      if (rbody["message"] == "sucess") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Notification added!!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Somthing went wrong please try again")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Somthing went wrong please try again")));
    }
  }

  Future<dynamic> bookturf(
      String turfid, bookingdate, bookingStatus, timeslot, daysno) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Turf_id": turfid,
      "bdate": bookingdate,
      "Cid": id,
      "Book_status": bookingStatus,
      "time_slot": timeslot,
      "days_no": daysno
    };
    print(body);
    var response = await post(Uri.parse("${url}book_turf.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      String? a = "e";

      if (rbody["Book_id"].isNotEmpty) {
        return rbody["Book_id"];
      }
    }
  }

  Future<dynamic> getNotification() async {
    var response = await get(Uri.parse("${url}view_notification.php"));
    if (response.statusCode == 200) {
      print(response.body);
      var rbody= jsonDecode(response.body);
      if(rbody[0]["message"] !="failed"){
        return jsonDecode(response.body);
      }

    }
  }

  Future<dynamic> addfeedback(
      String turfid, feedback, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {"Turf_id": turfid, "Cid": id, "Feedback": feedback};
    print(body);
    var response = await post(Uri.parse("${url}ins_feedback.php"), body: body);

    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);

      if (rbody["message"] == "sucess") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("feedback added")));
        return "sucess";
      }
    }
  }

  Future<dynamic> viewMyBooking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {"Cid": id};
    var response = await post(Uri.parse("${url}view_book.php"), body: body);
    if (response.statusCode == 200) {
      print(response.body);
      var rbody = jsonDecode(response.body);
      if (rbody[0]["message"] != "failed") {
        return rbody;
      }
      print(rbody);
    }
  }

  Future<dynamic> cancelbooking(String bookid) async {
    var body = {"Book_id": bookid,"Book_status":"cancel"};
    var response = await post(Uri.parse("${url}update_book.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      print(rbody);
      return rbody;
    }
  }

  Future<dynamic> payment(String bookid, paymentType, cardnumber, expdate, cvv,
      holdername, amount) async {
    var body = {
      "B_id": bookid,
      "payment_type": paymentType,
      "card_no": cardnumber,
      "expiry_date": expdate,
      "CVV": cvv,
      "holder_name": holdername,
      "amount": amount
    };
    var response = await post(Uri.parse("${url}ins_payment.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      print(rbody);
      return rbody;
    }
  }

  Future<dynamic> allRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Turf_id":id
    };
    var response = await post(Uri.parse("${url}view_turfrequest.php"), body: body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      print(rbody);
      if (rbody[0]["message"] != "failed") {
        return rbody;
      }


    }
  }


  Future<dynamic> acceptOrReject(String bookingid,status) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Book_id":bookingid,
      "status":status
    };
    var response = await post(Uri.parse("${url}approve_turfrequest.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      return rbody;


    }
  }


  Future<dynamic> history() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Turf_id":id,

    };
    var response = await post(Uri.parse("${url}view_turfhistory.php"), body: body);
    if (response.statusCode == 200) {
      var rbody = jsonDecode(response.body);
      print(rbody);
      if (rbody[0]["message"] != "failed") {
        return rbody;
      }


    }
  }


  Future<dynamic> paymenthistory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Turf_id":id,

    };
    var response = await post(Uri.parse("${url}view_payhistory.php"), body: body);

    if (response.statusCode == 200) {
      print(response.body);
      var rbody = jsonDecode(response.body);
      print(rbody);
      if (rbody[0]["message"] != "failed") {
        return rbody;
      }


    }
  }

  updateTurf(
      String tname,
      tlocation,
      accountnum,
      ownername,

      String email,
      String phone,

      String password,
      String rateperhours,
      String oldemailid,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    final fullurl = "${url}update_turf.php";
    var body = {
      "Turf_id":id,
      "Turf_name":tname,
      "Turf_location":tlocation,
      "owner_acc":accountnum,
      "owner_name":ownername,
      "Owner_email":email,
      "Owner_emailold":oldemailid,
      "owner_ph":phone,
      "password":password,
      "rate":rateperhours
    };

    print(body);

    var response = await post(Uri.parse("${url}update_turf.php"),body: body);

      if (response.statusCode == 200) {


        var rbody = jsonDecode(response.body);
        if (rbody["message"] == "sucess") {

          SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString("id", rbody["Turf_id"]);
          sharedPreferences.setString("name", rbody["Turf_name"]);
          sharedPreferences.setString("email", rbody["Owner_email"]);
          sharedPreferences.setString("type", rbody["user_type"]);
          sharedPreferences.setString("url", url);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile Updated")));
          Navigator.of(context).pushAndRemoveUntil(
            // the new route
            MaterialPageRoute(
              builder: (BuildContext context) => OwnerHomeScreen(),
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


  Future<dynamic> viewFeedback() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = await sharedPreferences.getString("id");
    var body = {
      "Turf_id":id,

    };
    var response = await post(Uri.parse("${url}view_feedback.php"), body: body);

    if (response.statusCode == 200) {
      print("feedback    ----${response.body}");
      print("feedback    ----${id}");
      var rbody = jsonDecode(response.body);
      print(rbody);
      if (rbody[0]["message"] != "failed") {
        return rbody;
      }


    }
  }



}
