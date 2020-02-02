import 'package:flutter/material.dart';
import 'package:flutter_login_demo/NavbarPages/profileform.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

Color PrimaryColor = Color(0xffac19d2);

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Padding(
            padding: EdgeInsets.only(top : 8.0),
            //child: _GooglePlayAppBar(),                 //Adding Search Capabilities
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            onTap: (index){
              setState(() { 
              switch (index) {
                case 0:
                PrimaryColor = Color(0xffa5682a);
                break;
                case 1:
                PrimaryColor = Color(0xff40d0e0);
                break;
              default:
              }
            });
            },
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    'Preview Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
           // profileForm(),
          ],
        ),
      ),
    );
  }
}
/*Widget _GooglePlayAppBar() {                                            //Extension of above child which returns the container
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
             onPressed: (null),
          ),
        ),
        Container(
          child: Text('Google Play',
          style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.microphone,color: Colors.blueGrey,
            ),
            onPressed: (null),
          ),
        ),
      ],
    ),
  );
}
*/