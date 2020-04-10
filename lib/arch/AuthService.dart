import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paymng/arch/models/appState.dart';
import 'package:paymng/arch/redux/actions.dart';
import 'package:paymng/pages/HomePage.dart';
import 'package:paymng/pages/LoginPage.dart';


class AuthService {

  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return HomePage(
            onInit: (){
              // StoreProvider.of<AppState>(context).dispatch(getUserAction);
            }
          );
        }
        else{
          return LoginPage();
        }
      },
    );
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }

  signIn(AuthCredential authCredential){
    FirebaseAuth.instance.signInWithCredential(authCredential);
  }
}