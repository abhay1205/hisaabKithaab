import 'package:firebase_database/firebase_database.dart';

class IndUser{

  String _id, _name, _state, _city, _email, _phoneNumber;

  IndUser(this._name, this._state, this._city, this._email, this._phoneNumber);

  IndUser.withID(this._id, this._name, this._state, this._city, this._email, this._phoneNumber);


  // GETTERS

  String get id => this._id;
  String get name => this._name;
  String get state => this._state;
  String get city => this._city;
  String get email => this._email;
  String get phoneNumber => this._phoneNumber;


  // SETTERS

  set name(String name){
    this._name = name;
  }
  set state(String state){
    this._state = state;
  }
  set city(String city){
    this._city = city;
  }
  set email(String email){
    this._email = email;
  }
  set phoneNumber(String phoneNumber){
    this._phoneNumber = phoneNumber;
  }


  // FROM SNAPSHOT TO USER CLASS
  IndUser.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._name = snapshot.value['name'];
    this._state = snapshot.value['state'];
    this._city = snapshot.value['city'];
    this._email = snapshot.value['email'];
    this._phoneNumber = snapshot.value['phoneNumber'];
  }


  // Converting the data to json format

  Map<String, dynamic> toJson(){
    return{
      'name': _name,
      'state': _state,
      'city': _city,
      'email': _email,
      'phoneNumber': _phoneNumber
    };
  }
}