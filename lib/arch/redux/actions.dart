
import 'package:paymng/arch/models/appState.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<AppState> getEmailPhoneAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final String phone = prefs.getString('number');
  final String email = prefs.getString('email');
  final String emailLinkNum = prefs.getString('email-linked-number'); 
  store.dispatch(GetEmailAction(email));
  store.dispatch(GetPhoneAction(phone));
};

// class GetUserAction{
//   final dynamic _user;
//   dynamic get user => this._user;

//   GetUserAction(this._user);
// }

class GetEmailAction{
  final String _email;

  String get email => this._email;

  GetEmailAction(this._email);
}

class GetPhoneAction{
  final String _phone;

  String get phone => this._phone;

  GetPhoneAction(this._phone);
}