import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/login_signup_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';


_launchURL(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//   startPayment() async {
//     Map<String, dynamic> options = new Map();
//     options.putIfAbsent("name", () => "Product name usually the project that i want to fund in.");
//     options.putIfAbsent("image", () => "Image link for the products description");
//     options.putIfAbsent("description", () => "This is a real transaction");
//     options.putIfAbsent("amount", () => "100");
//     options.putIfAbsent("email", () => "test@testing.com");
//     options.putIfAbsent("contact", () => "9988776655");
//     //Must be a valid HTML color.
//     options.putIfAbsent("theme", () => "#FFA500");
//     //Notes -- OPTIONAL
//     Map<String, String> notes = new Map();
//     notes.putIfAbsent('key', () => "value");
//     notes.putIfAbsent('randomInfo', () => "Information about the product");
//     options.putIfAbsent("notes", () => notes);
//     options.putIfAbsent("api_key", () => "API  KEY  HERE");
//     Map<dynamic,dynamic> paymentResponse = new Map();
//     paymentResponse = await Razorpay.showPaymentForm(options);
//     print("response $paymentResponse");

// }

class buildProfile extends StatefulWidget {
  @override
  _buildProfileState createState() => _buildProfileState();
}

class _buildProfileState extends State<buildProfile> {

  String searchtext;

  getSearchtext(searachtext) {
    this.searchtext = searchtext;
  }

  static const String iapId = 'android.test.purchased';
  List<IAPItem> _items = [];

  @override

  void initState() {
    super.initState();
    initPlatformState();
  }

    Future<void> initPlatformState() async {
    // prepare
    var result = await FlutterInappPurchase.initConnection;
    print('result: $result');

    if (!mounted) return;
    // refresh items for android
    String msg = await FlutterInappPurchase.consumeAllItems;
    print('consumeAllItems: $msg');
    await _getProduct();
  }

  Future<Null> _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.getProducts([iapId]);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
    });
  }

  Future<Null> _buyProduct(IAPItem item) async {
    try {
      PurchasedItem purchased = await FlutterInappPurchase.buyProduct(item.productId);
      print(purchased);
      String msg = await FlutterInappPurchase.consumeAllItems;
      print('consumeAllItems: $msg');
    }
    catch (error) {
      print('$error');
    }
  }

  List<Widget> _renderButton() {
    List<Widget> widgets = this._items.map((item) =>
      Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width*0.9,
          child: Column(
            children: <Widget>[
                  IconButton(
                  icon: Icon(FontAwesomeIcons.rupeeSign),
                  color: Colors.blue,
                  onPressed: () => _buyProduct(item),
              ),
            ]
          ),
        ),
    ).toList();
    return widgets;
  }

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 25.0,
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
          // IconButton(
          //   icon: Icon(
          //     Icons.search,
          //     size: 30,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //   }, //Blank On preses
          // ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Profiles').snapshots(),
        builder: (context, snapshot) {
            if (!snapshot.hasData) {
              const Text('Loading');
            } 
            else {
              return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot mypost = snapshot.data.documents[index];
                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 160.0,    //160
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 3.0,
                              shadowColor: Color(0x802196f3),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                        
                        child: Row(
                          children: <Widget>[

                            Expanded(                    
                            child: Image.network('${mypost['userProfilepic']}'),
                            flex: 2,
                            ),

                            Expanded(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Expanded(                          
                                    flex: 4,
                                    child: new Text('${mypost['userName']}',
                                    style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 4,
                                    child: new Text('${mypost['userDegree']}', //${mypost['userProfilepic']}
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 5,
                                    child: new Text('${mypost['userOccupation']}', //${mypost['userProfilepic']}
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
                          ],
                        ),
                              ),
                            ),
                          ),
                        ),
                        ),

                        Column(
                          children: <Widget>[
                          ExpansionTile(

                          title: Text('Know More ?'),
                          children: <Widget>[
                            
                            ExpansionTile(
                              title: Text('${mypost['userProject1']}'),
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('${mypost['userDescription1']}'),
                                )                                
                              ],
                            ),

                            ExpansionTile(
                              title: Text('${mypost['userProject2']}'),
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('${mypost['userDescription2']}'),
                                  ),                                
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                SizedBox(
                                  child: IconButton(
                                    icon: new Icon(Icons.phone,
                                  size: 30.0,), onPressed: (){
                                    _launchURL("tel:"+ mypost['userNumber']);
                                  },)
                                  //${mypost['userNumber']}
                                ),

                                SizedBox(
                                  child: IconButton(
                                    icon: Icon(Icons.mail_outline,size: 30.0,),
                                    onPressed: (){
                                      _launchURL("mailto:"+ mypost['userEmail']);
                                    },
                                  )
                                  //${mypost['userEmail']}
                                ),

                                SizedBox(
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.github,size: 30.0,),
                                    onPressed: (){
                                      _launchURL("http:"+ mypost['userGithub']);
                                    },
                                  )
                                  //child: Icon(FontAwesomeIcons.github,size: 30.0,),
                                  //${mypost['userGithub']}
                                ),
                                                            
                                SizedBox(
                                  height: 20.0,
                                  child: Text('Fund Needed \n ${mypost['userFund']}',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(children: this._renderButton()),

                            // SizedBox(
                            //   height: 10.0,
                            //   child: Text('${mypost['userFund']}',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 12.0
                            //   ),),
                            // ),
                            
                            // IconButton(
                            //   icon: Icon(FontAwesomeIcons.rupeeSign),
                            //   onPressed: () => _renderButton(),//startPayment(),
                            // ),
                          ],
                        ),
                        // Divider(
                        //   color: Colors.black,
                        //   height: 10.0,
                        // ),
                        ]
                        ),

                      ],
                    )
                  ],
                );
                
              }
            );
          }
        }
      ),
      
    );
  }
}

// import 'package:razorpay_plugin/razorpay_plugin.dart';
//   startPayment() async {
//     Map<String, dynamic> options = new Map();
//     options.putIfAbsent("name", () => "Razorpay T-Shirt");
//     options.putIfAbsent("image", () => "https://www.73lines.com/web/image/12427");
//     options.putIfAbsent("description", () => "This is a real transaction");
//     options.putIfAbsent("amount", () => "100");
//     options.putIfAbsent("email", () => "test@testing.com");
//     options.putIfAbsent("contact", () => "9988776655");
//     //Must be a valid HTML color.
//     options.putIfAbsent("theme", () => "#FF0000");
//     //Notes -- OPTIONAL
//     Map<String, String> notes = new Map();
//     notes.putIfAbsent('key', () => "value");
//     notes.putIfAbsent('randomInfo', () => "haha");
//     options.putIfAbsent("notes", () => notes);
//     options.putIfAbsent("api_key", () => "API_KEY_HERE");
//     Map<dynamic,dynamic> paymentResponse = new Map();
//     paymentResponse = await Razorpay.showPaymentForm(options);
//     print("response $paymentResponse");
// }

