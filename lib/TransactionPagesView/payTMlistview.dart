import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:core';

 class PaytmMsg{
    String senderName, amount, refNo, dateTime;
    
  }

class PayTMtransactions extends StatefulWidget {
  @override
  _PayTMtransactionsState createState() => _PayTMtransactionsState();
}

class _PayTMtransactionsState extends State<PayTMtransactions> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  // THE METHOD CHANNEL TO GET JAVA CODE RESPONSE IN FLUTTER
  static const platform = const MethodChannel("com.example.paymng/sms");

  List<dynamic> _sms = new List();
  int refresh = 0;

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

//  List<PaytmMsg> paytmSMS = new List();

//   void sorting(){
//     int i=0;
//     while( i<_sms.length){
//       if((_sms[i].contains("-iPaytm") || _sms[i].contains("-IPAYTM")) && _sms[i].contains("visit")){
//          paytmSMS[i].amount = _sms[i].contains("to")? _sms[i].substring(_sms[i].indexOf("Rs."), _sms[i].indexOf(" to")).replaceFirst("transferred", "")
//                         : _sms[i].substring(_sms[i].indexOf("Rs."), _sms[i].indexOf("Rs.") + 6);

//       paytmSMS[i].senderName =  _sms[i].substring(_sms[i].indexOf(" to") + 4, _sms[i].contains("on") ? 
//                                 _sms[i].indexOf(" on") : _sms[i].indexOf(" at"));

//       paytmSMS[i].refNo = _sms[i].contains("Ref:") ? _sms[i].substring(_sms[i].indexOf("Ref:"), _sms[i].indexOf("Ref:") + 16)
//                           : "Unknown";

//       paytmSMS[i].dateTime = _sms[i].substring( _sms[i].contains("on") ? _sms[i].indexOf(" on") + 3 : _sms[i].indexOf("at") + 2,
//                       _sms[i].contains("on") ? _sms[i].indexOf(" on") + 25 : _sms[i].indexOf("at") + 24);

//       i++;
//       }          
//     }
//     print(paytmSMS[0].amount);
//   }
  





  Future<Null> refreshBox() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    getAllSms();
  }

  @override
  void initState() {
    super.initState();
    getAllSms();
    // sorting();
    // clearSms();
  }

  // static String transaction =
  //     'SMS From: BP-iPaytm \n Paid Rs. 40 to Saras Parlour on Feb 27, 2020 13:08:57 with Ref: 29082096894. For more detils, visit https://p-t.tm/YmW-vY3 ';

  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sms.length,
      itemBuilder: (context, index) {
        String msg = _sms[index];
        print(_sms.length);
        return (msg.contains("-iPaytm") || msg.contains("-IPAYTM")) &&
                msg.contains("visit")
            ? Card(
              margin: EdgeInsets.only(top: 5, bottom:5),
                elevation: 10,
                child: ListTile(
                  // AMOUNT
                  leading: Text( index.toString(),
                    // msg.contains("to")
                    //     ? msg
                    //         .substring(msg.indexOf("Rs."), msg.indexOf(" to"))
                    //         .replaceFirst("transferred", "")
                    //     : msg.substring(
                    //         msg.indexOf("Rs."), msg.indexOf("Rs.") + 6),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  // SENDER
                  title: Text(
                    msg.substring(
                      msg.indexOf(" to") + 4,
                      msg.contains("on")
                          ? msg.indexOf(" on")
                          : msg.indexOf(" at"))),
                  // TRANSACTION ID
                  subtitle: msg.contains("Ref:")
                      ? Text(msg.substring(
                          msg.indexOf("Ref:"), msg.indexOf("Ref:") + 16))
                      : Text("Unknown"),
                  isThreeLine: true,
                  
                  // DATE TIME
                  trailing: Text(msg.substring(
                      msg.contains("on")
                          ? msg.indexOf(" on") + 3
                          : msg.indexOf("at") + 2,
                      msg.contains("on")
                          ? msg.indexOf(" on") + 25
                          : msg.indexOf("at") + 24
                      ), style: TextStyle(color: Colors.blue),),
                ),
              )
            : SizedBox(
                height: 0,
              );
      },
    );
  }
}
