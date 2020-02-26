package com.example.paymng;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.util.ArrayList;

import java.lang.*;
import java.util.List;

import android.Manifest;
import android.content.ContentResolver;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;



public class MainActivity extends FlutterActivity{
    private static final String CHANNEL = "com.example.paymng/sms";

    public class SmsDataFormat{
        String address, body;

        public SmsDataFormat(String address, String body){
            address = this.address;
            body = this.body;
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);

        ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.READ_SMS}, PackageManager.PERMISSION_GRANTED);
    }

    public String Read_Sms(){
        Cursor cursor = getContentResolver().query(Uri.parse("content://sms"), null, null, null, null);
        cursor.moveToFirst();

        String smsMsg = cursor.getString(12);
        return smsMsg;
    }

    public List<SmsDataFormat> refreshBox(){
        ContentResolver cResolver = getContentResolver();
        Cursor smsInboxCursor = cResolver.query(Uri.parse("content://sms/inbox"), null, null, null, null);

        int indexBody = smsInboxCursor.getColumnIndex("body");
        int indexAddress = smsInboxCursor.getColumnIndex("address");

        if(indexBody< 0 || !smsInboxCursor.moveToFirst()) return null;

        do{
            String address = "Sms From : " + smsInboxCursor.getString(indexAddress);
            String body = smsInboxCursor.getString(indexBody);
            List<SmsDataFormat> smsDataFormatList = new ArrayList<>();
            SmsDataFormat m = new SmsDataFormat(address, body);
            smsDataFormatList.add(m);
             return smsDataFormatList;
        }while (smsInboxCursor.moveToNext());
    }




    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            // TODO
                            if (call.method.equals("refreshBox")) {
//                                String msg = Read_Sms();
                                List<SmsDataFormat> smslist = refreshBox();

                                if (smslist != null) {
                                    result.success(smslist);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

}

























// public class MainActivity extends FlutterActivity {

//   private static final String CHANNEL = "com.example.paymng/readmsg";

//   private final static int REQUEST_CODE_PERMISSION_READ_SMS = 456;
//   ArrayList<String> smsMsgList = new ArrayList<String>();
//   public static MainActivity instance;

//   @Override
//   public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//     GeneratedPluginRegistrant.registerWith(flutterEngine);
//     new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//         .setMethodCallHandler(
//           (call, result) -> {
//             // Note: this method is invoked on the main thread.
//             // TODO
//             if (call.method.equals("getMessages")) {
//               ArrayList<String> smsMsgList = refreshBox();

//               if (smsMsgList != null) {
//                 result.success(smsMsgList);
//               } else {
//                 result.error("UNAVAILABLE", "No new message  available.", null);
//               }
//             } else {
//               result.notImplemented();
//             }
//           }
//         );
//   }

//   public static MainActivity Instance() {
//     return instance;
// }


// private boolean checkPermission(String permission){
//   int checkPermission = ContextCompat.checkSelfPermission(this, permission);
//   return  checkPermission == PackageManager.PERMISSION_GRANTED;
// }

//     public ArrayList<String> refreshBox(){
//         ContentResolver cResolver = getContentResolver();
//         Cursor smsInboxCursor = cResolver.query(Uri.parse("content://sms/inbox"), null, null, null, null);
//         int indexBody= smsInboxCursor.getColumnIndex("body");
//         int indexAddress = smsInboxCursor.getColumnIndex("address");

//         if(indexBody < 0 || !smsInboxCursor.moveToFirst()) return null;

//         do{
//             String str = "Sms from: " + smsInboxCursor.getString(indexAddress) + "\n";
//             str += smsInboxCursor.getString(indexBody);
//             smsMsgList.add(str);
//         }while (smsInboxCursor.moveToNext());

//         return  smsMsgList;
//     }

//     public void updateList(final String smsMsg){
//       smsMsgList.add(0, smsMsg);
//       smsMsgList.notifyAll();
//     }
// }
