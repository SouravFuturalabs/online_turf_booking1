import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';
import 'customerHomeScreen.dart';

class CustomerRegScreen extends StatefulWidget {
  const CustomerRegScreen({Key? key}) : super(key: key);

  @override
  State<CustomerRegScreen> createState() => _CustomerRegScreenState();
}

class _CustomerRegScreenState extends State<CustomerRegScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confimPassswordContoller = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isPasswordVisible1 = true;
  bool isPasswordVisible = true;

  dateselecting() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2025));
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date!);
    setState(() {
      dobController.text = formatted;
    });
  }

  File? pickedCustomerPhtot;
  bool isCustomerPhotoPicked = false;
  pickCustomerPhoto() async {
    ImagePicker imagePicker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        pickedCustomerPhtot = File(image.path);
                        isCustomerPhotoPicked = true;
                        Navigator.pop(context);
                      });
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
                        "Gallery",
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
                  onTap: () async {
                    XFile? image =
                        await imagePicker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        pickedCustomerPhtot = File(image.path);
                        isCustomerPhotoPicked = true;
                        Navigator.pop(context);
                      });
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
                        "Camera",
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
File? pickedIdProof;
bool isidproofpicked =false;
  pickIdProof() async {
    ImagePicker imagePicker = ImagePicker();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          content: Container(
            height: 100,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    XFile? image = await imagePicker.pickImage(
                        source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        pickedIdProof = File(image.path);
                        isidproofpicked = true;
                        Navigator.pop(context);
                      });
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
                        "Gallery",
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
                  onTap: () async {
                    XFile? image =
                        await imagePicker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      setState(() {
                        pickedIdProof = File(image.path);
                         isidproofpicked= true;
                        Navigator.pop(context);
                      });
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
                        "Camera",
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

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Register here..",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                    Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                             pickCustomerPhoto();
                            },
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: AppConstants.primarycolors,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )),
                    ],
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: pickedCustomerPhtot == null
                              ? NetworkImage(
                                  "https://thumbs.dreamstime.com/b/default-avatar-placeholder-profile-icon-male-eps-file-easy-to-edit-default-avatar-placeholder-profile-icon-male-139556753.jpg")
                              : FileImage(pickedCustomerPhtot!) as ImageProvider<Object>,
                          fit: BoxFit.cover),
                      border: Border.all(
                          color: AppConstants.primarycolors, width: 2)),
                ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Personal details",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

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
                      keyboardType: TextInputType.number,
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
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: isPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the password";
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
                          hintText: "Password",
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
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: confimPassswordContoller,
                      obscureText: isPasswordVisible1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the confirm password";
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
                          hintText: "Confirm password",
                          suffixIcon:  isPasswordVisible1 == true
                              ? InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordVisible1 = false;
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
                                isPasswordVisible1 = true;
                              });
                            },
                            child: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Address details",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: addressController,
                      maxLines: 5,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the Address";
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
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        pickIdProof();
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 80,
                                child: Text(
                                  pickedIdProof == null
                                      ? "Id Proof"
                                      : pickedIdProof!.path
                                          .toString()
                                          .substring(51, 80),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.document_scanner,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppConstants.primarycolors, width: 2)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: InkWell(
                      onTap: () {
                        final valid = formKey.currentState!.validate();
                        if (valid == true) {
                          if (passwordController.text ==
                              confimPassswordContoller.text) {

                                if(isCustomerPhotoPicked == true && isidproofpicked == true){
 Service().customerRegNew(
                                nameController.text,
                                addressController.text,
                                dobController.text,
                                phoneController.text,
                                emailController.text,
                                passwordController.text,
                                context,
                                pickedCustomerPhtot!,
                                pickedIdProof!
                            );
                                }else{
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please upload user photo and id proof")));
                                }
                           
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Password and confirm password  NOT match")));
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Text(
                            "Register",
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
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
