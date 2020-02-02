import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart'; //get the file name from the gallery
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



String userUrl,hintdob="DD/MM/YYYY",hintemail="xyz@gmail.com",hintnumber="+917845123695",hintfund="in INR";

class profilePic extends StatefulWidget {
  @override
  _profilePicState createState() => _profilePicState();
}

class _profilePicState extends State<profilePic> {

  File _image;
  var downloadurl;

  getUserUrl(userUrl) {
    userUrl = userUrl;
    // this.userUrl = userUrl;
  }

  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
       _image=image;
       print('Image Path $_image');
      });
    }

    Future getCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
       _image=image;
       print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName=basename(_image.path);
      StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
      String url = (await firebaseStorageRef.getDownloadURL()).toString();
      // String url = (await firebaseStorageRef.getDownloadURL()).toString();
      userUrl = url;
      getUserUrl(userUrl);
      print(userUrl);      
      // downloadurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      // url = downloadurl.toString();
      setState(() {
          print("Profile");
          //Scaffold.of(context).showSnackBar(Snackbar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Center(

      child: Builder(
        builder: (context) => SingleChildScrollView(        //To make page scrollable
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ), //In Column one this is the first widget
                  Row(
//                                                                           In Column one this is the second widget
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 95.0,
                          backgroundColor: Colors.lightBlue,
                          child: ClipOval(
                            child: SizedBox(
                                width: 170.0,
                                height: 170.0,
                                child:(_image!=null)?Image.file(_image,fit: BoxFit.fill,):

                                Image.network(
                                  "https://media.istockphoto.com/vectors/golf-players-character-design-in-flat-color-line-style-male-and-vector-id916018166",
                                  //"https://maxcdn.icons8.com/app/uploads/2016/10/male-female-icons.png",     //Alternate link
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                            Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera, //Some dumb icons but whatever!!
                                size: 30.0,
                              ),
                              onPressed: () {
                                getCamera();
                              },
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.perm_media, //Some dumb icons but whatever!!
                                size: 26.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                   RaisedButton(
                     color: Colors.lightBlue,
                     onPressed: () {
                      uploadPic(context);
                      Fluttertoast.showToast(
                        msg: "Image Uploaded Successfully !",
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
                    elevation: 4.0,
                    splashColor: Color(0xFF64B5F6),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        child: Icon(Icons.label_important),
                      ),                    

                      Padding(
                      padding: EdgeInsets.only(top: 25.0,bottom: 20.0),                 
                      child: Text('Please submit and proceed to the Profile Form',
                      style: TextStyle(fontSize: 14.0),),
                      )
                    ],
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

String Name,Email;

class profileForm extends StatefulWidget {
  @override
  _profileFormState createState() => _profileFormState();
}

class _profileFormState extends State<profileForm> {

  String  userName,userAddress,userDob,userDegree,userOccupation,userEmail,userGithub,userNumber,userProject1,userDescription1,
          userProject2,userDescription2,userFund;

  getUserName(userName) {
    this.userName = userName;
  }
  getUserAddress(userAddress) {
    this.userAddress = userAddress;
  }
  getUserDob(userDob) {
    this.userDob = userDob;
  }
  getUserDegree(userDegree) {
    this.userDegree = userDegree;
  }
  getUserOccupation(userOccupation) {
    this.userOccupation = userOccupation;
  }
  getUserEmail(userEmail) {
    this.userEmail = userEmail;
  }
  getUserGithub(userGithub) {
    this.userGithub = userGithub;
  }
  getUserNumber(userNumber) {
    this.userNumber = userNumber;
  }
  getUserProject1(userProject1) {
    this.userProject1 = userProject1;
  }
  getUserDescription1(userDescription1) {
    this.userDescription1 = userDescription1;
  }
  getUserProject2(userProject2) {
    this.userProject2 = userProject2;
  }
  getUserDescription2(userDescription2) {
    this.userDescription2 = userDescription2;
  }
  getUserFund(userFund) {
    this.userFund = userFund;
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Profiles').document(userName);
      Map<String, dynamic> tasks = {
      "userName": userName,
      "userAddress": userAddress,
      "userDob": userDob,
      "userEmail": userEmail,
      "userDegree": userDegree,
      "userOccupation": userOccupation,
      "userGithub": userGithub,
      "userNumber": userNumber,
      "userProject1": userProject1,
      "userDescription1": userDescription1,
      "userProject2": userProject2,
      "userDescription2": userDescription2,
      "userProfilepic": userUrl,
      "userFund": userFund
    };
    ds.setData(tasks).whenComplete(() {
      print("Profile Creation Successful");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Builder(
        builder: (context) => SingleChildScrollView(        //To make page scrollable
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,                  
                  ),
                  SizedBox(
                    height: 20.0,
                    child: Text('Please Enter your Profile Details',style: TextStyle(fontSize: 18.0),),
                  ),

                  SizedBox(
                    height: 10.0,
                  ), //In Column one this is the first widget

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String userName) {
                       getUserName(userName);Name=userName;
                    },
                    decoration: InputDecoration(labelText: "Your Full Name:",prefixIcon: Icon(Icons.account_box)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),


                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String userAddress) {
                       getUserAddress(userAddress);
                    },
                    decoration: InputDecoration(labelText: "Your Address:",prefixIcon: Icon(FontAwesomeIcons.addressCard)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.datetime,
                    onChanged: (String userDob) {
                       getUserDob(userDob);},
                    decoration: InputDecoration(labelText: "DOB:",
                    prefixIcon: Icon(Icons.date_range),
                    hintText: hintdob,
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // maxLength: 10,
                    // keyboardType: TextInputType.text,
                    onChanged: (String userDegree) {
                       getUserDegree(userDegree);},
                    decoration: InputDecoration(labelText: "Your Degree",
                    prefixIcon: Icon(FontAwesomeIcons.listAlt),
                    // hintText: hintdob,
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // maxLength: 10,
                    // keyboardType: TextInputType.text,
                    onChanged: (String userOccupation) {
                       getUserOccupation(userOccupation);},
                    decoration: InputDecoration(labelText: "Your Occupation",
                    prefixIcon: Icon(Icons.work),
                    // hintText: hintdob,
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // maxLength: 10,
                    // keyboardType: TextInputType.number,
                    onChanged: (String userEmail) {
                       getUserEmail(userEmail);Email=userEmail;},
                    decoration: InputDecoration(labelText: "Enter your Email Id:",
                    prefixIcon: Icon(Icons.email,),
                    hintText: hintemail,                                        
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    // maxLength: 10,
                    // keyboardType: TextInputType.number,
                    onChanged: (String userGithub) {
                       getUserGithub(userGithub);},
                    decoration: InputDecoration(labelText: "Enter your Github Id:",
                    prefixIcon: Icon(FontAwesomeIcons.github,
                    )),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLength: 13,
                    keyboardType: TextInputType.phone,
                    onChanged: (String userNumber) {
                       getUserNumber(userNumber);
                    },
                    decoration: InputDecoration(labelText: "Phone Number:",
                    prefixIcon: Icon(Icons.contact_phone,),
                    hintText: hintnumber,
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String userProject1) {
                       getUserProject1(userProject1);
                    },
                    decoration: InputDecoration(labelText: "Project 1 Title",prefixIcon: Icon(Icons.assignment_ind)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLines: 2,
                    onChanged: (String userDescription1) {
                       getUserDescription1(userDescription1);
                    },
                    decoration: InputDecoration(labelText: "Project 1 Description",
                      prefixIcon: Icon(Icons.assignment)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    onChanged: (String userProject2) {
                       getUserProject2(userProject2);
                    },
                    decoration: InputDecoration(labelText: "Project 2 Title",prefixIcon: Icon(Icons.assignment_ind)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLines: 2,
                    onChanged: (String userDescription2) {
                       getUserDescription2(userDescription2);
                    },
                    decoration: InputDecoration(labelText: "Project 2 Description",prefixIcon: Icon(Icons.assignment)),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    onChanged: (String userFund) {
                       getUserFund(userFund);
                    },
                    decoration: InputDecoration(labelText: "Fund Needed:",
                    prefixIcon: Icon(FontAwesomeIcons.rupeeSign,),
                    hintText: hintfund,
                    ),
                    cursorColor: Colors.orangeAccent,
                  ),
                ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        elevation: 4.0,
                        splashColor: Color(0xFF64B5F6),
                        child: Text(
                          'Back to Home',
                          style: TextStyle(color: Colors.white, fontSize: 16.0)
                        ),
                      ),

                      RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          // uploadPic(context);
                          createData();
                          Fluttertoast.showToast(
                            msg: "Profile Created Successfully !",
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
                        elevation: 4.0,
                        splashColor: Color(0xFF64B5F6),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 16.0)
                        ),
                      ),
                    ],
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Container(
                  //         child: Column(
                  //           children: <Widget>[
                  //             Align(
                  //                 alignment: Alignment.centerLeft,
                  //                 child: TextField(
                  //                   onChanged: (String taskName) {
                  //                     // getTaskName(taskName);
                  //                   },
                  //                   decoration: InputDecoration(labelText: "Your Name:"),
                  //                 ),)
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
      ),
    );
  }
}
