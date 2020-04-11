import 'package:paymng/arch/models/BusinessUser.dart';
import 'package:paymng/arch/models/IndividualUser.dart';
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

class GetEmailAction {
  final String _email;

  String get email => this._email;

  GetEmailAction(this._email);
}

class GetPhoneAction {
  final String _phone;

  String get phone => this._phone;

  GetPhoneAction(this._phone);
}

ThunkAction<AppState> getUserProfileAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> bUserList = prefs.getStringList('bUser');
  final List<String> indUserList = prefs.get('indUser');
  BUser bUser;
  IndUser indUser;
  if (bUserList != null) {
    bUser = BUser(bUserList[0], bUserList[1], bUserList[2], bUserList[3]);
  } else {
    indUser = IndUser(indUserList[0], indUserList[1], indUserList[2]);
  }
  if (bUser != null) {
    store.dispatch(GetBUserAction(bUser));
  } else {
    store.dispatch(GetIndUserAction(indUser));
  }
};

class GetBUserAction {
  final BUser _user;

  BUser get bUser => this._user;

  GetBUserAction(this._user);
}

class GetIndUserAction {
  final IndUser _user;

  IndUser get indUser => this._user;

  GetIndUserAction(this._user);
}
