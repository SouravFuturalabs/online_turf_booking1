import 'package:flutter/material.dart';
import 'package:online_turf_booking/controller/apis.dart';

import '../../utilites/appconstants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Map? selectedturf;
  List<Map> turfs = [];

  TextEditingController feedbackController = TextEditingController();


  getturf()async{
    var data = await Service().getfullturfdeatils();
    print(data);
    data.forEach((element) {
      setState(() {
        turfs.add({"Turf_name": element["Turf_name"], "id": element["Turf_id"]});
      });
    });

    print(turfs);
  }

  @override
  void initState() {
    // TODO: implement initState
    getturf();
    super.initState();
  }
  final formKey = GlobalKey<FormState>();

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
                      "Write your feedback",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4,top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppConstants.primarycolors, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: IgnorePointer(
                            ignoring: false,
                            child: DropdownButton<Map>(
                              isExpanded: true,
                              elevation: 0,

                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),

                              hint: Text(
                                ' Please choose Turf',
                              ), // Not necessary for Option 1
                              value: selectedturf,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedturf = newValue;
                                  print(selectedturf);
                                });
                              },
                              items: turfs.map((location) {
                                return DropdownMenuItem(
                                  child: Container(
                                    child: new Text(
                                      location["Turf_name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                       controller: feedbackController,
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter the Feedback";
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
                          hintText: "Feedback",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: InkWell(
                      onTap: ()async {
                        final valid = formKey.currentState!.validate();

                        if(valid == true){
                         var data = await Service().addfeedback(selectedturf!["id"], feedbackController.text, context);
                         if(data =="sucess"){
                           setState(() {
                             feedbackController.clear();
                           });
                         }
                        }
                        print(selectedturf!["id"]);
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
                            "Submit",
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
            ),
          ),
        ),
      ),
    );
  }
}
