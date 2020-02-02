import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/login_signup_page.dart';

class searchProfile extends StatefulWidget {
  @override
  _searchProfileState createState() => _searchProfileState();
}

class _searchProfileState extends State<searchProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_left,
              size: 40.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            alignment: Alignment.center,
            child: Text('User Profiles ', style: TextStyle()),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {}, //Blank On preses
            )
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('Profiles')   //My Collection Name.
              .snapshots(),             //My collection Name it is .  Some star wars refference
          builder: (context, snapshot) {
//                                                     Build method passing the context and the snapshot aka my data.
            if (!snapshot.hasData) {
              const Text('Loading');
            } 
            else {
              return ListView.builder(
                  itemCount: snapshot
                      .data.documents.length, //List of documents there exists.
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost =
                        snapshot.data.documents[index]; //Value from my document

                    return Stack(
                      children: <Widget>[
                        Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 160.0, //350.0
                            child: Padding(
                            // padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              padding: EdgeInsets.all(12.0),
                              child: Material(
                                color: Colors.white,
                                elevation: 14.0,
                                shadowColor: Color(0x802196f3),
                                child: Center(
                                child: Padding(
                                padding: EdgeInsets.all(
                                10.0,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      // width: 200,
                                      // //width:
                                      // //   MediaQuery.of(context).size.width,
                                      // height: 200.0,
                                      child: Image.network(
                                        '${mypost['userProfilepic']}',
                                      ),
                                      flex: 2,
                                      // fit: BoxFit.fill),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: new Text(
                                              '${mypost['userName']}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: new Text(
                                              '${mypost['userEmail']}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: new Text(
                                              '${mypost['userGithub']}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 3,
                                    ),
                                    // SizedBox(
                                    //   height: 10.0,
                                    // ),
                                    // Text(
                                    //   '${mypost['title']}',
                                    //   style: TextStyle(
                                    //       fontSize: 20.0,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    // SizedBox(
                                    //   height: 10.0,
                                    // ),
                                    // Text(
                                    //   '${mypost['subtitle']}',
                                    //   style: TextStyle(
                                    //       fontSize: 20.0,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.blueGrey),
                                    // ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                        ExpansionTile(
                          // leading: Icon(Icons.arrow_drop_down),
                          // trailing: Icon(Icons.arrow_drop_down),
                          title: Text('${mypost['userProject1']}'),
                          children: <Widget>[
                            Text('${mypost['userDescription1']}')
                          ],
                        ),
                        ExpansionTile(
                          // leading: Icon(Icons.arrow_drop_down),
                          // trailing: Icon(Icons.arrow_drop_down),
                          title: Text('${mypost['userProject2']}'),
                          children: <Widget>[
                            Text('${mypost['userDescription2']}')
                          ],
                        ),
                        ExpansionTile(
                          // leading: Icon(Icons.arrow_drop_down),
                          // trailing: Icon(Icons.arrow_drop_down),
                          title: Text('Contact Details'),
                          children: <Widget>[
                            Text('${mypost['userNumber']}'),
                            Text('${mypost['userEmail']}'),
                            Text('${mypost['userGithub']}'),
                          ],
                        ),
                      ]),
                      // Container(
                      //   alignment: Alignment.topRight,
                      //   padding: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * .47,
                      //     left: MediaQuery.of(context).size.height * .52,
                      //   ),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     child: CircleAvatar(
                      //       backgroundColor: Color(0xff543B7A),
                      //       child: Icon(Icons.bookmark,
                      //           color: Colors.white, size: 20.0),
                      //     ),
                      //   ),
                      // ),
                    ]);
                  });
            }
          },
        ));
  }
}

_launchURL(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}




