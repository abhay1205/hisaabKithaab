import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:core';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  static const platform = const MethodChannel("com.example.paymng/sms");
  List<dynamic> _sms = new List();
  
  Future<void> _refreshInbox() async {
    List<dynamic> sms = new List();
    sms.add("Hello");
    try {
      sms.addAll(await platform
          .invokeMethod('refreshSmsInbox'));  // replace the result data structure
    } on PlatformException catch (e) {
      print("error getting messages\n");
    }

    setState(() {
      _sms = sms;
    });
    print("length:" + sms.length.toString());
  }

  @override
  void initState() {
    _refreshInbox();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: ListView.builder(
            itemCount: _sms.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: ListTile(
                  leading: Text(
                    "Rs. ${index+1}",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _refreshInbox,
        label: Text("Refresh", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
