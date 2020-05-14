import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paymng/arch/AuthService.dart';
import 'package:paymng/arch/models/appState.dart';
import 'package:paymng/arch/redux/actions.dart';
import 'package:paymng/arch/redux/reducer.dart';
import 'package:paymng/pages/DashBoard.dart';
import 'package:paymng/pages/HomePage.dart';
import 'package:paymng/pages/LoginPage.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/services.dart' ;

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/dash': (BuildContext context) => DashBoard(
            onInit: (){
              StoreProvider.of<AppState>(context).dispatch(getEmailPhoneAction);
            }
          ),
          '/home': (BuildContext context) => HomePage(
            onInit: (){
              StoreProvider.of<AppState>(context).dispatch(getUserProfileAction);
            }
          ),
        },
      ),
    );
  }
}
