import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paymng/AppBarWidgets/DrawerPage.dart';
import 'package:paymng/TransactionPagesView/TransactionList.dart';
import 'package:paymng/TransactionPagesView/payTMlistview.dart';
import 'package:paymng/TransactionPagesView/upiListView.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  String pageViewName = "Home";

  @override
  void initState() {
    pageViewName = "Home";
    super.initState();
  }

  Widget barButtons(){
    return PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                     onTap: (){
                      setState(() {
                        pageViewName = "Home";
                      });
                    },
                       child: Container(
                      child: Icon(
                      Typicons.home_outline,
                      color: pageViewName == "Home"? Colors.redAccent: Colors.white,
                    )),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageViewName = "Paytm";
                      });
                    },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 2),
                          decoration: pageViewName == "Paytm"? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle
                          ): null,
                        height: 35,
                        child: Image.asset(
                          'asset/Paytm.png',
                          color: Colors.cyan[200],
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageViewName = "UPI";
                      });
                    },
                        child: Container(
                           padding: EdgeInsets.only(bottom: 2),
                          decoration: pageViewName == "UPI"? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle
                          ): null,
                        height: 35,
                        child: Image.asset(
                          'asset/Bhim(1).png',
                          color: Colors.cyan[200],
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageViewName = "G-Pay";
                      });
                    },
                      child: Container(
                         padding: EdgeInsets.only(bottom: 2),
                          decoration: pageViewName == "G-Pay"? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle
                          ): null,
                      height: 35,
                      child:  Image.asset(
                          'asset/google pay.png',
                          color: Colors.cyan[200],
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.fitHeight,
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageViewName = "PhonePe";
                      });
                    },
                      child: Container(
                         padding: EdgeInsets.only(bottom: 2),
                          decoration: pageViewName == "PhonePe"? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle
                          ): null,
                      height: 35,
                      child: Image.asset(
                          'asset/searchpng.com-phonepe-icon.png',
                          color: Colors.cyan[200],
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.fitHeight,
                        )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        pageViewName = "Card";
                      });
                    },
                      child: Container(
                         padding: EdgeInsets.only(bottom: 1.5),
                          decoration: pageViewName == "Card"? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle
                          ): null,
                      height: 35,
                      child:  Image.asset(
                          'asset/Smart Card.png',
                          color: Colors.cyan[200],
                          colorBlendMode: BlendMode.colorBurn,
                          fit: BoxFit.fitHeight,
                        )
                    ),
                  ),
                ],
              ),
            ),
          ); 
  }

  Widget bodyView(){
    return Container(
      padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
      margin: EdgeInsets.only(right: 10, left: 10, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: Colors.cyan[200] ),
      child: listView(pageViewName),
    );
  }

  Widget listView(String pageName){
    if(pageName == "Paytm"){
      return PayTMtransactions();
    }
    else if(pageName == "UPI"){
      return UpiList();
    }
    else if(pageName == "G-Pay"){
      return Center(
        child: Text("G-Pay Coming Soon")
      );
    }
    else if(pageName == "PhonePe"){
      return  Center(
        child: Text("PhonePe Coming Soon")
      );
    }
    else if(pageName == "Card"){
      return  Center(
        child: Text("Card Coming Soon")
      );
    }
    else if(pageName == "Home"){
      return  Center(
        child: Text("Home")
      );
    }
    return  Center(
        child: Text("Error")
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.cyan[200],
          centerTitle: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hisabh",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              Text("Kitabh", style: TextStyle(color: Colors.red, fontSize: 25)),
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
