// package com.example.paymng;
//
//import android.content.BroadcastReceiver;
//import android.content.Context;
//import android.content.Intent;
//import android.os.Build;
//import android.os.Bundle;
//import android.telephony.SmsMessage;
//import android.widget.Toast;
//
// public class SmsBroadcastReceiver extends BroadcastReceiver {
//
//    public static final String SMS_BUNDLE = "pdus";
//
//    public void onReceive(Context context, Intent intent) {
//        Bundle intentExtras = intent.getExtras();
//        if(intent.getAction().equalsIgnoreCase("android.provider.Telephony.RECEIVED_SMS")){
//
//            if (intentExtras != null) {
//                Object[] sms = (Object[]) intentExtras.get(SMS_BUNDLE);
//                String smsMessageStr = "";
//                SmsMessage smsMessage;
//                for (int i = 0; i < sms.length; ++i) {
//                    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
//                        String format = intentExtras.getString("format");
//                        smsMessage = SmsMessage.createFromPdu((byte[]) sms[i], format);
//                    }else {
//                        smsMessage = SmsMessage.createFromPdu((byte[]) sms[i]);
//                    }
//
//
//                    String smsBody = smsMessage.getMessageBody().toString();
//                    String address = smsMessage.getOriginatingAddress();
//
//                    smsMessageStr += "SMS From: " + address + "\n";
//                    smsMessageStr += smsBody + "\n";
//                }
//                Toast.makeText(context, smsMessageStr, Toast.LENGTH_SHORT).show();
//
//                //this will update the UI with message
//                MainActivity inst = MainActivity.instance();
//                inst.updateList(smsMessageStr);
//            }
//        }
//
//    }
//}