package com.example.paymng;

import android.content.ContentResolver;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.ArrayList;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;



public class MainActivity extends FlutterActivity{
    private static final String CHANNEL = "com.example.paymng/sms";

    private static MainActivity inst;
    ArrayList<String> smsMessagesList = new ArrayList<>();

    public ArrayList<String> getSmsMessagesList() {
        return smsMessagesList;
    }

    public void setSmsMessagesList(ArrayList<String> smsMessagesList) {
        this.smsMessagesList = smsMessagesList;
    }



    public static MainActivity instance() {
        return inst;
    }
//
//    @Override
//    public void onStart() {
//        super.onStart();
//        inst = this;
//    }

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);

    }

//    public String Read_Sms(){
//        Cursor cursor = getContentResolver().query(Uri.parse("content://sms"), null, null, null, null);
//        cursor.moveToFirst();
//
//        String smsMsg = cursor.getString(12);
//        return smsMsg;
//    }
//

//
//    public String refreshBox(){
//        ContentResolver cResolver = getContentResolver();
//        Cursor smsInboxCursor = cResolver.query(Uri.parse("content://sms/inbox"),
//                null, null, null, null);
//
//        int indexBody = smsInboxCursor.getColumnIndex("body");
//        int indexAddress = smsInboxCursor.getColumnIndex("address");
//
//        if(indexBody< 0 || !smsInboxCursor.moveToFirst()) return null;
//
//        do{
//            String address = "Sms From : " + smsInboxCursor.getString(indexAddress) + "\n";
//            String body = smsInboxCursor.getString(indexBody);
//            String res = address + body;
//             return res;
//        }while (smsInboxCursor.moveToNext());
//    }


    public ArrayList<String> refreshSmsInbox() {
        ContentResolver contentResolver = getContentResolver();
        Cursor smsInboxCursor = contentResolver.query(Uri.parse("content://sms/inbox"), null, null, null, null);
        int indexBody = smsInboxCursor.getColumnIndex("body");
        int indexAddress = smsInboxCursor.getColumnIndex("address");
        if (indexBody < 0 || !smsInboxCursor.moveToFirst()) return null;


        do {
            String str = "SMS From: " + smsInboxCursor.getString(indexAddress) +
                    "\n" + smsInboxCursor.getString(indexBody) + "\n";
            smsMessagesList.add(str);
        } while (smsInboxCursor.moveToNext());



        return smsMessagesList;
    }

    public void updateList(final String smsMessage) {
        smsMessagesList.add(0, smsMessage );
        smsMessagesList.notifyAll();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            // TODO
                            if (call.method.equals("refreshSmsInbox")) {
//                                String msg = Read_Sms();
                                ArrayList<String> smsMessagesList1 = refreshSmsInbox();

                                if (smsMessagesList1 != null) {
                                    result.success(smsMessagesList1);
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
