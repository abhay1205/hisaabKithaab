import 'package:firebase_database/firebase_database.dart';

class BUser{

  String _id, _bName, _bType,_email, _phoneNumber;

  BUser(this._bName, this._bType, this._email, this._phoneNumber);

  BUser.withID(this._id, this._bName, this._bType, this._email, this._phoneNumber);


  // GETTERS

  String get id => this._id;
  String get bName => this._bName;
  String get bType => this._bType;
  // String get state => this._state;
  // String get city => this._city;
  String get email => this._email;
  String get phoneNumber => this._phoneNumber;


  // SETTERS

  set bName(String bName){
    this._bName = bName;
  }
  set bType(String bType){
    this._bType = bType;
  }
  // set state(String state){
  //   this._state = state;
  // }
  // set city(String city){
  //   this._city = city;
  // }
  set email(String email){
    this._email = email;
  }
  set phoneNumber(String phoneNumber){
    this._phoneNumber = phoneNumber;
  }


  // FROM SNAPSHOT TO USER CLASS
  BUser.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._bName = snapshot.value['bName'];
    this._bType = snapshot.value['bType'];
    // this._state = snapshot.value['state'];
    // this._city = snapshot.value['city'];
    this._email = snapshot.value['email'];
    this._phoneNumber = snapshot.value['phoneNumber'];
  }


  // Converting the data to json format

  Map<String, dynamic> toJson(){
    return{
      'bName': _bName,
      'bType': _bType,
      // 'state': _state,
      // 'city': _city,
      'email': _email,
      'phoneNumber': _phoneNumber
    };
  }
}