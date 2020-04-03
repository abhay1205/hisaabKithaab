
import 'package:paymng/arch/models/appState.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();
  final List<dynamic> storedUser = prefs.getStringList('info');
  final String user = storedUser!=null? prefs.getString('user'): null;
  final String number = prefs.getString('number');
  store.dispatch(GetUserAction(user!=null?user:number));
};

class GetUserAction{
  final dynamic _user;
  dynamic get user => this._user;

  GetUserAction(this._user);
}