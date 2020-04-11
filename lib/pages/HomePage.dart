import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paymng/AppBarWidgets/DrawerPage.dart';
import 'package:paymng/TransactionPagesView/payTMlistview.dart';
import 'package:paymng/TransactionPagesView/upiListView.dart';
import 'package:paymng/arch/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;

  HomePage({this.onInit});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String pageViewName = "Home";
  var screenSize;
  bool _isLoggedOut;

  @override
  void initState() {
    widget.onInit();
    pageViewName = "Home";
    super.initState();
  }
  
  //  ALL LOGIC PART

  checkAuthentication() async{
    _auth.onAuthStateChanged.listen((user){
      if(user == null){
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  // GOOGLE SIGN OUT

  void userSignout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _auth.signOut();
  }

  // LOG OUT DIALOG
  showLogOut() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'ALERT',
              style: TextStyle(color: Colors.cyan),
            ),
            content: Text(
              'Are you sure, you want to log out',
              style: TextStyle(color: Colors.cyan),
            ),
            actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.cyan,
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 100,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.cyan,
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _isLoggedOut = false;
                  });
                  Future.delayed(Duration(seconds: 2), (){
                    userSignout();
                    setState(() {
                      _isLoggedOut = true;
                    });
                    Navigator.of(context).pushReplacementNamed('/login');
                  });
                  
                },
              ),
            ],
          );
        });
  }

  showProgress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          
          if(_isLoggedOut == true) {
            Navigator.of(context).pop();
          }
          return AlertDialog(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              alignment: Alignment.center,
              height: screenSize * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                  ),
                  SizedBox(
                    height: screenSize * 0.01,
                  ),
                  Text(
                    "Siging Out",
                    style: TextStyle(color: Colors.cyan),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget barButtons() {
    return PreferredSize(
      preferredSize: Size.fromHeight(35),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: screenSize > 600
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  pageViewName = "Home";
                });
              },
              child: Container(
                  child: Icon(
                Typicons.home_outline,
                color: pageViewName == "Home" ? Colors.redAccent : Colors.white,
              )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageViewName = "Paytm";
                });
              },
              child: Container(
                  padding: EdgeInsets.only(bottom: 2),
                  decoration: pageViewName == "Paytm"
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle)
                      : null,
                  height: 35,
                  child: Image.asset(
                    'asset/Paytm.png',
                    color: Colors.cyan[400],
                    colorBlendMode: BlendMode.colorBurn,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageViewName = "UPI";
                });
              },
              child: Container(
                  padding: EdgeInsets.only(bottom: 2),
                  decoration: pageViewName == "UPI"
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle)
                      : null,
                  height: 35,
                  child: Image.asset(
                    'asset/Bhim(1).png',
                    color: Colors.cyan[400],
                    colorBlendMode: BlendMode.colorBurn,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageViewName = "PhonePe";
                });
              },
              child: Container(
                  padding: EdgeInsets.only(bottom: 2),
                  decoration: pageViewName == "PhonePe"
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle)
                      : null,
                  height: 35,
                  child: Image.asset(
                    'asset/searchpng.com-phonepe-icon.png',
                    color: Colors.cyan[400],
                    colorBlendMode: BlendMode.colorBurn,
                    fit: BoxFit.fitHeight,
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageViewName = "Card";
                });
              },
              child: Container(
                  padding: EdgeInsets.only(bottom: 1.5),
                  decoration: pageViewName == "Card"
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle)
                      : null,
                  height: 35,
                  child: Image.asset(
                    'asset/Smart Card.png',
                    color: Colors.cyan[400],
                    colorBlendMode: BlendMode.colorBurn,
                    fit: BoxFit.fitHeight,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyView() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      margin: screenSize > 600
          ? EdgeInsets.only(right: 200, left: 200, top: 40)
          : EdgeInsets.only(right: 10, left: 10, top: 30),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan, width: 3),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white),
      child: listView(pageViewName),
    );
  }

  Widget listView(String pageName) {
    if (pageName == "Paytm") {
      return PayTMtransactions();
    } else if (pageName == "UPI") {
      return UpiList();
    } else if (pageName == "G-Pay") {
      return Center(child: Text("G-Pay Coming Soon"));
    } else if (pageName == "PhonePe") {
      return Center(
          child: Text(
        "PhonePe Coming Soon",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));
    } else if (pageName == "Card") {
      return Center(
          child: Text(
        "Card Coming Soon",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ));
    } else if (pageName == "Home") {
      return Center(child: Text("Home"));
    }
    return Center(child: Text("Error"));
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh, color: Colors.white), onPressed: null),
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              showLogOut();
            },
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 2,
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Hisaab",
                style: TextStyle(
                    color: Colors.white, fontSize: screenSize > 600 ? 35 : 25)),
            Text(" Kitaab",
                style: TextStyle(
                    color: Colors.red, fontSize: screenSize > 600 ? 35 : 25)),
            SizedBox(
              width: 10,
            ),
            // Icon(FontAwesomeIcons.book, color: Colors.redAccent, size: 20,),
          ],
        ),
        bottom: barButtons(),
      ),
      drawer: DrawerPage(),
      body: bodyView(),
    );
  }
}
