import 'package:paymng/arch/models/appState.dart';
import 'package:paymng/arch/redux/actions.dart';

AppState appReducer(state, action) {
  return AppState(
      // user: userReducer(state.user, action
      email: emailReducer(state.email, action),
      phone: phoneReducer(state.phone, action),
      bUser: bUserReducer(state.bUser, action),
      indUser: indUserReducer(state.indUser, action));
}

emailReducer(email, action) {
  if (action is GetEmailAction) {
    return action.email;
  }
  return email;
}

phoneReducer(phone, action) {
  if (action is GetPhoneAction) {
    return action.phone;
  }
  return phone;
}

bUserReducer(bUser, action) {
  if (action is GetBUserAction) {
    return action.bUser;
  }
  return bUser;
}

indUserReducer(indUser, action) {
  if (action is GetIndUserAction) {
    return action.indUser;
  }
  return indUser;
}
