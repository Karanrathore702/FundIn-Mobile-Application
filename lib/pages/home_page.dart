import 'package:flutter/material.dart';
import 'package:flutter_login_demo/NavbarPages/About.dart';
import 'package:flutter_login_demo/NavbarPages/feedback.dart';
import 'package:flutter_login_demo/NavbarPages/profile.dart';
import 'package:flutter_login_demo/NavbarPages/profileform.dart';
import 'package:flutter_login_demo/NavbarPages/search.dart';
import 'package:flutter_login_demo/NavbarPages/searching.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_login_demo/models/todo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_signup_page.dart';
import '../NavbarPages/profileform.dart';
import 'package:share/share.dart';


import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    _checkEmailVerification();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(_onEntryChanged);
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      // _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Please verify account in the link sent to email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Resent link"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _addNewTodo(String todoItem) {
    if (todoItem.length > 0) {
      Todo todo = new Todo(todoItem.toString(), widget.userId, false);
      _database.reference().child("todo").push().set(todo.toJson());
    }
  }

  _updateTodo(Todo todo) {
    //Toggle completed
    todo.completed = !todo.completed;
    if (todo != null) {
      _database.reference().child("todo").child(todo.key).set(todo.toJson());
    }
  }

  _deleteTodo(String todoId, int index) {
    _database.reference().child("todo").child(todoId).remove().then((_) {
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    });
  }

  _showDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _addNewTodo(_textEditingController.text.toString());
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  // void _showSnackBar(BuildContext context) {
  //   ClipboardManager.copyToClipBoard("Here will be the downloading link of my app.").then((result) {
  //     var snackBar = SnackBar(
  //       content: Text('Copied to Clipboard'),
  //       backgroundColor: Colors.orange,
  //       action: SnackBarAction(
  //       label: 'Undo',                                      //snackbar not working but text get copied
  //       onPressed: () {                                     //going to use toast now becoz it aint working.                  
  //       debugPrint('Snackbar testing');
  //       },
  //       ),
  //       );
  //     Scaffold.of(context).showSnackBar(snackBar);
  //   });
  // }

void _showToast (BuildContext context) {
    ClipboardManager.copyToClipBoard("Here will be the downloading link of my app.").then((result) {
      Fluttertoast.showToast(
        msg: "Link copied to clipboard !!",
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Color(0xFF64B5F6),
      );
    });
}

  Widget _showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            String todoId = _todoList[index].key;
            String subject = _todoList[index].subject;
            bool completed = _todoList[index].completed;
            String userId = _todoList[index].userId;
            return Dismissible(
              key: Key(todoId),
              background: Container(color: Colors.red),
              onDismissed: (direction) async {
                _deleteTodo(todoId, index);
              },
              child: ListTile(
                title: Text(
                  subject,
                  style: TextStyle(fontSize: 20.0),
                ),
                trailing: IconButton(
                    icon: (completed)
                        ? Icon(
                            Icons.done_outline,
                            color: Colors.green,
                            size: 20.0,
                          )
                        : Icon(Icons.done, color: Colors.grey, size: 20.0),
                    onPressed: () {
                      _updateTodo(_todoList[index]);
                    }),
              ),
            );
          });
    } else {
      return Center(
          child: Text(
        "Welcome to FundIn",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //leading: IconButton(
        //  icon: Icon(FontAwesomeIcons.bars),
        //  onPressed: () {},
        //),
        backgroundColor: Color(0xFF64B5F6),
        title: new Text('                FundIN',
        style: TextStyle(
          fontSize: 24.0
        ),
        ),
        //actions: <Widget>[
        //  new FlatButton(
        //      child: Icon(Icons.power_settings_new),
        //      onPressed: _signOut)
        //],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text('$Name'), //Text('$Name'),                                   //TODO change name to users given name
              accountEmail: new  Text("$Email"),//Text("$Email"),              //TODO change email to users given name
              decoration: new BoxDecoration(
              image: new DecorationImage(
                alignment: Alignment.centerRight,
                image: new NetworkImage("https://www.vactualpapers.com/web/wallpapers/new-google-inspired-material-design-hd-wallpaper-24/thumbnail/lg.jpg"),fit: BoxFit.cover,
              ),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage('$userUrl'),  /* TODO change picture to users given picture*/
              ),
            ),

            new ListTile(                         // For Searching projects page redirection 
              leading: const Icon(Icons.search),
              title: new Text('Search Projects'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new buildProfile()));
              },
            ),

            new ListTile(                         // For Seeing the funded projects
              leading: const Icon(FontAwesomeIcons.wallet),
              title: new Text('Manage Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ProfilePage()));
              },
            ),
            
            // new ListTile(                         // For Editing and previewing Profile Details.
            //   leading: const Icon(Icons.assignment_ind),
            //   title: new Text('Your Profile'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) => new profileForm()));
            //   },
            // ),

/*            new ListTile(                         // For Editing and previewing Project Details.
              leading: const Icon(Icons.folder_shared),
              title: new Text('Your Projects'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),
*/
            new ListTile(                         // Copy to clipboard download link of the app.
              leading: const Icon(Icons.share),
              title: new Text('Invite Others'),
              onTap: () { _showToast(context);
              Share.share('Check out FundIn a platform to give your projects a \n https://downloadlinkoffundin');
              },
            ),
            
            new Divider(                          //For creating Dark Linr in between the Drawer.
              height: 10.0,
              color: Colors.black,
            ),

            new ListTile(                         //About Page redirection.
              leading: const Icon(Icons.help),
              title: new Text('About FundIn'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
            ),

            // new ListTile(                         //Settings Page redirection.
            //   leading: const Icon(Icons.settings),
            //   title: new Text('Settings'),
            //   onTap: () {
            //     Navigator.of(context).pop();
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (BuildContext context) => new AboutPage()));
            //   },
            // ),

            new ListTile(                         //Help & Feedback Page Redirection.
              leading: const Icon(Icons.feedback),
              title: new Text('Help & Feedback'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new feedbackPage()));
              },              
            ),

            new ListTile(                         //Logout Functionality in Drawer itself.
              onTap: _signOut,                     //Redirection to signout class.
              leading: const Icon(Icons.power_settings_new),
              title: Text('Logout'),
            )

          ],
        ),
      ),
      //body: _showTodoList(),
      //floatingActionButton: FloatingActionButton(                 
      //  backgroundColor: Colors.orange,
      //  onPressed: () {
      //    ;//_showDialog(context);
      //  },
      //  tooltip: 'Increment',
      //  child: Icon(Icons.add),
      //)
      //bottomNavigationBar: BottomAppBar(                          //Bottom navbar
      //  color : Colors.orange,
      //),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

          SizedBox(
            height: 30.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 15.0,
              child: Image.network('//Link of the image'),
            ),
          ),

          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 15.0,
              child: Image.network('//Link of the image'),
            ),
          ),
            ],
          ),

          SizedBox(
            height: 20.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

          Align(
            alignment: Alignment.center,
            // height: 25,
            // width: 100,
            child: Text("Ayush Somani",
            style: TextStyle(
              fontSize: 18,
            ),
            )
          ),

          Align(
            alignment: Alignment.center,
            // height: 25,
            // width: 100,
            child: Text("Riya Subhedar",
            style: TextStyle(
              fontSize: 18,
            ),)
          ),
            ],
          ),

            SizedBox(
              height: 20.0,
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Align(
            alignment: Alignment.center,
            // height: 100,
            // width: MediaQuery.of(context).size.width,
            child: Text("Top Investors of FundIN",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20.0
            ),
            )
          ),
            ],
          ),


          SizedBox(
            height: 50.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 15.0,
              child: Image.network('//Link of the image'),
            ),
          ),

          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              radius: 15.0,
              child: Image.network('//Link of the image'),
            ),
          ),
            ],
          ),

          SizedBox(
            height: 20.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

          Align(
            alignment: Alignment.center,
            // height: 25,
            // width: 100,
            child: Text("Prateek Rawat",
            style: TextStyle(
              fontSize: 18.0,
            ),
            )
          ),

          Align(
            alignment: Alignment.center,
            // height: 25,
            // width: 100,
            child: Text("Sarah Sharma",
            style: TextStyle(
              fontSize: 18.0,
            ),)
          ),
            ],
          ),

            SizedBox(
              height: 20.0,
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Align(
            alignment: Alignment.center,
            // height: 100,
            // width: MediaQuery.of(context).size.width,
            child: Text("Top Investee's of FundIN",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 22.0
            ),
            )
          ),
            ],
          ),


          SizedBox(
            height: 20.0,
          ),

      Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 240.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _imageCarousel("//Link of the image",
            "Karan Rathore",
            "Freelancer"
            ),            
            _imageCarousel("//Link of the image",
            "Mrinal Dixit",
            "Freelancer"
            ),
            
            _imageCarousel("//Link of the image",
            "Fakhruddin Ezzey",
            "Teacher in Catalyser"
            ),
            _imageCarousel("//Link of the image",
            "Ayush Bhokare",
            "Student"
            ),
            _imageCarousel("//Link of the image",
            "Ashutosh Agarwal",
            "Job at L&T"
            ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Our Prestigious FunIN User",
            style: TextStyle(
              fontSize: 20.0
            ),
            ),
          ),

          SizedBox(
            height: 50.0,
          ),

        ],
      ),
    )
    );
  }
}

_imageCarousel(String imageVal,String heading,String subHeading) {

  return  Container(
    width: 150.0,
    child: Card(
      child: Wrap(
        children: <Widget>[
          SizedBox(
            height: 160.0,
            width: 152.0,
            child: Image.network("$imageVal"
            ),
          ),
          // Divider(
          //   color: Colors.black,
          // ),
          ListTile(
            title: Text("$heading"),
            subtitle: Text("$subHeading"),
            )
          ],
        ),
      ),
    );
  
}
