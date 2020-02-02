import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:flutter_login_demo/pages/root_page.dart';
import 'pages/login_signup_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        // darkTheme: new ThemeData.dark(),
        // theme: ThemeData.light(),
        // theme: ThemeData(
        //   brightness: Brightness.dark,
        //   primarySwatch: Colors.lightBlue,
        //   accentColor: Colors.lightBlue
        // ),
        home: new RootPage(auth: new Auth()));
  }
}