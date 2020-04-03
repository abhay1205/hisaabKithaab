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
      _sms.toSet().toList();
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
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sms.length,
      itemBuilder: (context, index) {
        String msg = _sms[index];

        return (msg.contains("SBI UPI") && msg.contains("A/c")) 
            ? Container(
                  margin: EdgeInsets.only(top: 5, bottom:5),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.cyan, width: 2),
                     borderRadius: BorderRadius.circular(30),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    //   stops: [0.0, 0.2, 0.6, 0.9],
                    //   colors: [Colors.amber[400], Colors.amber[200], Colors.amber[100], Colors.white])
                  ),
                  child: ListTile(
                    // CREDIT/DEBIT
                    leading:  msg.contains("credited") ? 
                    Text("Credit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)) : 
                    Text("Debit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    // AMOUNT
                    title: Text(msg.substring(msg.indexOf("Rs"), msg.indexOf("on")), textAlign: TextAlign.center,),
                    // TRANSACTION ID
                    subtitle: Text(msg.substring(
                            msg.indexOf("Ref"), msg.indexOf("Ref") + 19), textAlign: TextAlign.center,)
                        ,
                    isThreeLine: true,
                    
                    // DATE TIME
                    trailing: Text(msg.substring(
                        msg.indexOf(" on") + 3,
                        msg.indexOf(" on") + 11
                        ), style: TextStyle(color: Colors.cyan[400])),
                  ),
              )
            : SizedBox(
                height: 0,
              );
      },
    );
  }
}