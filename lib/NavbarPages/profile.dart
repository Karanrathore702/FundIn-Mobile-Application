import 'package:flutter/material.dart';
import 'package:flutter_login_demo/NavbarPages/profileform.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

//Color PrimaryColor = Color(0xffac19d2);

class _ProfilePageState extends State<ProfilePage> {

int _selectedPage = 0;
final _pageOptions = [
  profilePic(),
  profileForm(),
];
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF64B5F6),          //backgroundColor: PrimaryColor,
          title: Padding(
            child: Text("Create Profile"),
            padding: EdgeInsets.only(top : 8.0), 
          ),
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
             _selectedPage = index; 
            });
            debugPrint("$index");
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              title: Text('Profile Picture')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('Profile Form')
            ),
          ],
        ),
      ),
    );
  }
}