
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:core';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  // THE METHOD CHANNEL TO GET JAVA CODE RESPONSE IN FLUTTER
  static const platform = const MethodChannel("com.example.paymng/sms");

  
  List<dynamic> _sms = new List();
  int refresh =0;

  void clearSms(){
    _sms.clear();
  }

  Future<void> getAllSms() async {

    List<dynamic> sms = new List();
    // _sms.clear();
    sms.clear();
    try {
      sms.addAll(await platform.invokeMethod(
          'refreshSmsInbox')); // replace the result data structure
    } on PlatformException catch (e) {
      print("error getting messages\n");
    }

    setState(() {
      // this is set as when the sms data is send to db and read back,then no duplicates will there (assumption) 
      // if(refresh ==0 || _sms[0] != sms [0]  ){
        _sms = sms;
      // R
    });
    
  }
  Future<Null> refreshBox() async{

    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));

    getAllSms();

  }

  @override
  void initState() {
    super.initState();
    clearSms();
  }

  Widget balanceStatus() {
    return PreferredSize(
      preferredSize: Size.fromHeight(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.topCenter,
              width: 60,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40)),
              child: Text("Today",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40)),
              child: Text("Yesterday",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              alignment: Alignment.topCenter,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40)),
              child: Text("Monthly",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget appbar(){
    return AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.blueAccent,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            "Rs.2000",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        bottom: balanceStatus(),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              alignment: Alignment.center,
              child: Text("sms inbox: ${_sms.length} ",
                  style: TextStyle(color: Colors.white)))
        ],
      );
  }

  Widget transactionList(){
    return RefreshIndicator(
      onRefresh: refreshBox,
      key: refreshKey,
          child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: ListView.builder(
              itemCount: _sms.length,
              itemBuilder: (context, index) {

                String msg = _sms[index];
                try{
                  print(msg.substring(
                    msg.indexOf("Rs.")
                    , msg.indexOf("to") ));
                }catch(e){
                  print("error");
                }
                
                return Card(
                  elevation: 10,
                  child: ListTile(
                    leading: Text(
                      "10",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(_sms[index]),
                    subtitle: Text("Transaction ID"),
                    isThreeLine: true,
                    trailing: Text("Date/Time"),
                  ),
                );
              }),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: appbar(),
      body: transactionList(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _refreshInbox,
      //   label: Text("Refresh", style: TextStyle(color: Colors.white)),
      //   backgroundColor: Colors.blueAccent,
      // ),
    );
  }
}
