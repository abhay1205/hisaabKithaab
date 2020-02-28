import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:core';

class UpiList extends StatefulWidget {
  @override
  _UpiListState createState() => _UpiListState();
}

class _UpiListState extends State<UpiList> {

   var refreshKey = GlobalKey<RefreshIndicatorState>();

  // THE METHOD CHANNEL TO GET JAVA CODE RESPONSE IN FLUTTER
  static const platform = const MethodChannel("com.example.paymng/sms");

  List<dynamic> _sms = new List();
  int refresh = 0;

  void clearSms() {
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

  Future<Null> refreshBox() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));

    getAllSms();
  }

  @override
  void initState() {
    super.initState();
    getAllSms();
    clearSms();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sms.length,
      itemBuilder: (context, index) {
        String msg = _sms[index];

        return (msg.contains("SBI UPI") && msg.contains("A/c")) 
            ? Card(
              margin: EdgeInsets.only(top: 5, bottom:5),
                elevation: 10,
                child: ListTile(
                  // CREDIT/DEBIT
                  leading: Text( msg.contains("credited") ? "Credit" : "Debit"),
                  // AMOUNT
                  title: Text(msg.substring(msg.indexOf("Rs"), msg.indexOf("on"))),
                  // TRANSACTION ID
                  subtitle: Text(msg.substring(
                          msg.indexOf("Ref"), msg.indexOf("Ref") + 19))
                      ,
                  isThreeLine: true,
                  
                  // DATE TIME
                  trailing: Text(msg.substring(
                      msg.indexOf(" on") + 3,
                      msg.indexOf(" on") + 11
                      )),
                ),
              )
            : SizedBox(
                height: 0,
              );
      },
    );
  }
}