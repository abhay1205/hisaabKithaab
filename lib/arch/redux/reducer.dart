
import 'package:paymng/arch/models/appState.dart';
import 'package:paymng/arch/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(user: userReducer(state.user, action));
}

userReducer(user, action){
  if(action is GetUserAction){
    return action.user;
  }
  return user;
}