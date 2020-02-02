import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


//import 'package:flutter_login_demo/NavbarPages/profileform.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class feedbackPage extends StatefulWidget {
  feedbackPage();
  @override
  _feedbackPageState createState() => _feedbackPageState();
}

//Color PrimaryColor = Color(0xffac19d2);

class _feedbackPageState extends State<feedbackPage> {
  
  String taskName, taskDetails, taskDate; //, taskTime;

  getTaskName(taskName) {
    this.taskName = taskName;
  }

  getTaskDetails(taskDetails) {
    this.taskDetails = taskDetails;
  }

  getTaskDate(taskDate) {
    this.taskDate = taskDate;
  }

  // getTaskTime(taskTime) {
  //   this.taskTime = taskTime;
  // }

  int _myTaskType = 0;
  String taskVal;

  void _handelTaskType(int value) {
    //For radio Buttons
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          taskVal = 'Pixel Overflow Issues';
          break;
        case 2:
          taskVal = 'Bugs on rotation of app';
          break;
        case 3:
          taskVal = 'Payment Failures';
          break;
        case 4:
          taskVal = 'Managing profiles';
          break;
        case 5:
          taskVal = 'Others';
          break;
      }
    });
  }            

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('feedback').document(taskName);
    Map<String, dynamic> tasks = {
      "taskname": taskName,
      "taskdetails": taskDetails,
      "taskdate": taskDate,
      // "tasktime": taskTime,
      "tasktype":taskVal,
    };
    ds.setData(tasks).whenComplete(() {
      print("FeedBack done");
    });
  }

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

  @override
  Widget build(BuildContext context) { 
    _portraitModeOnly();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,        //-80 becoz app bar is container with height 80 XD So much for gradient
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String taskName) {
                      getTaskName(taskName);
                    },
                    decoration: InputDecoration(labelText: "Name:",prefixIcon: Icon(Icons.account_box)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String taskDetails) {
                      getTaskDetails(taskDetails);
                    },
                    decoration: InputDecoration(labelText: "Details:",prefixIcon: Icon(Icons.assignment)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String taskDate) {
                      getTaskDate(taskDate);
                    },
                    decoration: InputDecoration(labelText: "Date:",prefixIcon: Icon(Icons.calendar_today)),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
                //   child: TextField(
                //     onChanged: (String taskTime) {
                //       getTaskTime(taskTime);
                //     },
                //     decoration: InputDecoration(labelText: "Time:",prefixIcon: Icon(Icons.alarm)),
                //   ),
                // ),
               
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Select if problems are mentioned below.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//Row 1

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value:
                              1, //Value stored for the radio buttons for the problem type.
                          groupValue:
                              _myTaskType, //Upper defined myTaskType value.
                          onChanged:
                              _handelTaskType, //when Fadio buttons are pressed.
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Pixel overflow issues',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),

//Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value:
                              2, //Value stored for the radio buttons for the problem type.
                          groupValue:
                              _myTaskType, //Upper defined myTaskType value.
                          onChanged:
                              _handelTaskType, //when Fadio buttons are pressed.
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Bugs on rotation of app',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),

//Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value:
                              3, //Value stored for the radio buttons for the problem type.
                          groupValue:
                              _myTaskType, //Upper defined myTaskType value.
                          onChanged:
                              _handelTaskType, //when Fadio buttons are pressed.
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Payment Failures',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),

//Row 4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value:
                              4, //Value stored for the radio buttons for the problem type.
                          groupValue:
                              _myTaskType, //Upper defined myTaskType value.
                          onChanged:
                              _handelTaskType, //when Fadio buttons are pressed.
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Managing profiles',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),

//Row 5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value:
                              5, //Value stored for the radio buttons for the problem type.
                          groupValue:
                              _myTaskType, //Upper defined myTaskType value.
                          onChanged:
                              _handelTaskType, //when Fadio buttons are pressed.
                          activeColor: Color(0xff4158ba),
                        ),
                        Text(
                          'Others',
                          style: TextStyle(fontSize: 16.0),
                        )
                      ],
                    ),

//This is the button to Add/Create an entry and to cancle the request.
//This one below is for the cancleing the request
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Color(0xFF64B5F6),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    RaisedButton(
                      color: Color(0xFF64B5F6),
                      onPressed: () {
                        createData(); //To call a class to add the details to the firestore
                        Fluttertoast.showToast(
                          msg: "Thanks For your Response !",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Color(0xFF64B5F6),       //Below are properties to manipulate toast.
                          timeInSecForIos: 2,
                          // msg: "This is Center Short Toast", 
                          // toastLength: Toast.LENGTH_SHORT,
                          // gravity: ToastGravity.CENTER,
                          // timeInSecForIos: 1,
                          // backgroundColor: Colors.red,
                          // textColor: Colors.white,
                           fontSize: 14.0
                        );
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
                ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _myAppBar(context) {
  return Container(
    height: 80.0,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color(0xFF64B5F6),
          const Color(0xFF64B5F6),
          
          // const Color(0xFFFB8C00),
          // const Color(0xFFFFB74D),
          
          // const Color(0xFFF26609),
          // const Color(0xFFED9A25),
        ],
        begin: Alignment.centerRight,
        end: new Alignment(-1.0, -1.0),
      ),
    ),
    //For inputting anything in the appbar.
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              //flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(                  
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                    size: 25.0,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),                    
                  ),
                  
                Center(
                  child: Text(
                  '            Feedback Form',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    // decorationStyle: TextDecorationStyle.dashed,
                    // decorationColor: Colors.black,
                    color: Colors.black,
                    fontFamily: "Roboto-Regular",
                    fontWeight: FontWeight.w400,
                    fontSize: 22.0),
                ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}