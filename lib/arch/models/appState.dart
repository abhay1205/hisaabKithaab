import 'package:meta/meta.dart';
import 'package:paymng/arch/models/BusinessUser.dart';
import 'package:paymng/arch/models/IndividualUser.dart';

@immutable

class AppState {
  final String email;
  final String phone;
  final BUser bUser;
  final IndUser indUser;

  AppState({
    @required this.email, 
    @required this.phone, 
    this.bUser, 
    this.indUser});

  factory AppState.initial(){
    return AppState(
      email: null,
      phone: '+91',
      bUser: null,
      indUser: null);
  }
}