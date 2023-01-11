import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:online_turf_booking/controller/apis.dart';
import 'package:online_turf_booking/screens/customer/customerHomeScreen.dart';

import '../../utilites/appconstants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? pickedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPassswordContoller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  dateselecting() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date!);
    setState(() {
      dobController.text = formatted;
    });
  }

  // pickimage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Pick Image From"),
  //         content: Container(
  //           height: 100,
  //           child: Column(
  //             children: [
  //               InkWell(
  //                 onTap: () async {
  //                   XFile? image = await imagePicker.pickImage(
  //                       source: ImageSource.gallery);
  //
  //                   if (image != null) {
  //                     setState(() {
  //                       pickedImage = File(image.path);
  //                       Navigator.pop(context);
  //                     });
  //                   }
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 190,
  //                   decoration: BoxDecoration(
  //                       color: AppConstants.primarycolors,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.grey,
  //                           offset: Offset(4, 4),
  //                           spreadRadius: 1,
  //                           blurRadius: 2,
  //                         )
  //                       ],
  //                       borderRadius: BorderRadius.all(Radius.circular(20))),
  //                   child: Center(
  //                     child: Text(
  //                       "Gallery",
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 15,
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   XFile? image =
  //                       await imagePicker.pickImage(source: ImageSource.camera);
  //
  //                   if (image != null) {
  //                     setState(() {
  //                       pickedImage = File(image.path);
  //                       Navigator.pop(context);
  //                     });
  //                   }
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   width: 190,
  //                   decoration: BoxDecoration(
  //                       color: AppConstants.primarycolors,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Colors.grey,
  //                           offset: Offset(4, 4),
  //                           spreadRadius: 1,
  //                           blurRadius: 2,
  //                         )
  //                       ],
  //                       borderRadius: BorderRadius.all(Radius.circular(20))),
  //                   child: Center(
  //                     child: Text(
  //                       "Camera",
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  bool isPasswordVisible = true;
  String? oldemail;

  getdetails() async {
    var response = await Service().getCustomerdetails();
    setState(() {
      nameController.text = response["Cname"];
      emailController.text = response["CEmail"];
      phoneController.text = response["CPhone_no"];
      dobController.text = response["Cdob"];
      addressController.text = response["Caddress"];
      passwordController.text = response["password"];

      oldemail = response["Caddress"];
    });
    print(response);
  }

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    getdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Container(
                //   height: 150,
                //   width: 150,
                //   child: Stack(
                //     children: [
                //       Align(
                //           alignment: Alignment.bottomRight,
                //           child: InkWell(
                //             onTap: () {
                //               pickimage();
                //             },
                //             child: Container(
                //                 height: 50,
                //                 width: 50,
                //                 decoration: BoxDecoration(
                //                     color: AppConstants.primarycolors,
                //                     shape: BoxShape.circle),
                //                 child: Icon(
                //                   Icons.edit,
                //                   color: Colors.white,
                //                 )),
                //           )),
                //     ],
                //   ),
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //           image: pickedImage == null
                //               ? NetworkImage(
                //                   "https://thumbs.dreamstime.com/b/default-avatar-placeholder-profile-icon-male-eps-file-easy-to-edit-default-avatar-placeholder-profile-icon-male-139556753.jpg")
                //               : FileImage(pickedImage!) as ImageProvider<Object>,
                //           fit: BoxFit.cover),
                //       border: Border.all(
                //           color: AppConstants.primarycolors, width: 2)),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the name";
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
                        hintText: "Name",
                        labelText: "Name",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the phone number";
                      }
                      if (value.length != 10) {
                        return "please enter correct phone number";
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
                        hintText: "Phone number",
                        labelText: "Phone number",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: dobController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the date of birth";
                      }
                    },
                    readOnly: true,
                    onTap: () {
                      dateselecting();
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
                        hintText: "DOB",
                        labelText: "DOB",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),

                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please ente the email";
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
                        hintText: "E-mail",
                        labelText: "E-mail",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: addressController,
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the username";
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
                        hintText: "Address",
                        labelText: "Address",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: isPasswordVisible,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter the Password";
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
                        suffixIcon: isPasswordVisible == true
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = false;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = true;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                        hintText: "Password",
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: AppConstants.primarycolors,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: InkWell(
                    onTap: () async{
                      final valid = formKey.currentState!.validate();
                      if (valid == true) {
                       var result = await Service().updatecustomerprofile(
                            nameController.text,
                            emailController.text,
                            oldemail,
                            dobController.text,
                            addressController.text,
                            passwordController.text,
                            phoneController.text,
                          context
                        );

                       if(result == "sucess"){
                         getdetails();
                         Navigator.of(context).pushAndRemoveUntil(
                           // the new route
                           MaterialPageRoute(
                             builder: (BuildContext context) => CustomerHomeScreen(),
                           ),

                               (Route route) => false,
                         );
                       }
                      }
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
                          "Update",
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
        ),
      ),
    );
  }
}
