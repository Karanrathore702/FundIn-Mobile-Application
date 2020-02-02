import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

//Color PrimaryColor = Color(0xffffff);               //Color PrimaryColor = Color(0xffac19d2);

class Textbox {
  static String fundintitle = "  ";
  static String fundinversion =
      "Version 2.19.98";
  static String fundincopyright =
       " © 2019 - 20 FundIn Inc. ";
  static String fundindeveloper = " Designed & Developed by: Karan Rathore";
}

class _AboutPageState extends State<AboutPage> {
  Widget textsection = Container(
    child: new Column(
      children: <Widget>[

        // Padding 1 for 1st text
        Padding(
            padding: const EdgeInsets.all(10),
            child: Text( 
              Textbox.fundinversion,
              style: TextStyle(
                  color: Color(0xFFC8CEF0),       //color: new Color(0xfff9f3ee),
                  fontSize: 18,
                  //fontWeight: FontWeight.bold
                ),
            )
        ),

        //Padding 2 for the 2nd text
            Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              Textbox.fundindeveloper,
              style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
            )
        ),

            Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              Textbox.fundincopyright,
              style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
            )
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: Colors.transparent,          //backgroundColor: PrimaryColor,
          title: Text(Textbox.fundintitle),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height/8,
            ),
            Center(child: Image.asset('assets/fundin.png', height: 260, width: 180),),
            Center(
              child: textsection,
            ),
          ],
        ),
      ),
    );
  }
}
