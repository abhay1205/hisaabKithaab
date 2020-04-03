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
  List<dynamic> _final = new List();
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
      _final =_sms.toSet().toList();
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
      itemCount: _final.length,
      itemBuilder: (context, index) {
        String msg = _final[index];
        print(_sms.length);
        print(_final.length);
        return (msg.contains("-iPaytm") || msg.contains("-IPAYTM")) &&
                msg.contains("visit")
            ? Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                    // AMOUNT
                    leading: 
                      Text(msg.contains("to")
                          ? msg
                              .substring(msg.indexOf("Rs."), msg.indexOf(" to"))
                              .replaceFirst("transferred", "")
                          : msg.substring(
                              msg.indexOf("Rs."), msg.indexOf("Rs.") + 6),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    // SENDER
                    title: Text( 
                      msg.substring(
                        msg.indexOf(" to") + 4,
                        msg.contains("on")
                            ? 
                            msg.indexOf(" on")
                            : 
                            msg.indexOf(" at")
                            ).toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),),
                    // TRANSACTION ID
                    subtitle: msg.contains("Ref:")
                        ? Text(
                          msg.substring(
                            msg.indexOf("Ref:"), msg.indexOf("Ref:") + 16),
                            textAlign: TextAlign.center,)
                        : Text("Unknown", textAlign: TextAlign.center,),
                    isThreeLine: true,
                    
                    // DATE TIME
                    trailing: Text(
                      '\n' +
                      msg.substring(
                        msg.contains("on")
                            ? msg.indexOf(" on") + 3
                            : msg.indexOf("at") + 2,
                        msg.contains("on")
                            ? msg.indexOf(" on") + 16
                            : msg.indexOf("at") + 15
                        ) + '\n'
                          + msg.substring(
                            msg.contains("on")
                            ? msg.indexOf(" on") + 16
                            : msg.indexOf("at") + 15,
                            msg.contains("on")
                            ? msg.indexOf(" on") + 25
                            : msg.indexOf("at") + 24
                          ), 
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.cyan[400]),),
                  ),
              )
            : SizedBox(
                height: 0,
              );
      },
    );
  }
}
