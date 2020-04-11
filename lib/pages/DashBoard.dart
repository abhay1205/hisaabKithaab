import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paymng/arch/models/BusinessUser.dart';
import 'package:paymng/arch/models/IndividualUser.dart';
import 'package:paymng/arch/models/appState.dart';
import 'package:paymng/arch/redux/actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType { Business, Individual }

class DashBoard extends StatefulWidget {
  final void Function() onInit;
  DashBoard({this.onInit});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  // SETTING INTIAL VALUE OF RADIO BUTTOM
  UserType _userType = UserType.Business;
  double screenSize;
  final _formKey = GlobalKey<FormState>();
  // INTIALIZING ALL THE VARIABLES
  String _bName = '', _bType = '', _email = '', _phoneNumber = '+91';
  String bTypeDropdownValue, stateDropdownValue, cityDropdownValue;
  bool _isRegistered;

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  // ALL WIDGETS

  // LOGO

  Widget _logo() {
    return Container(
        height: screenSize * 0.2,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/Logo.jpeg'),
            fit: BoxFit.contain,
            colorFilter: new ColorFilter.mode(
                Colors.red.withOpacity(0.6), BlendMode.dstATop),
          ),
        ),
        child: Container(
            padding: EdgeInsets.only(top: 25),
            alignment: Alignment.topCenter,
            child: Text('Hisaab Kitaab',
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 50,
                    fontWeight: FontWeight.w400))));
  }

  // RADIO OPTION BUTTON

  Widget _userTypeRadio() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(15, 0, 10, 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan, width: 3),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Business',
            style: TextStyle(fontSize: 17),
          ),
          Radio(
            activeColor: Colors.cyan,
            value: UserType.Business,
            groupValue: _userType,
            onChanged: (UserType value) {
              setState(() {
                _userType = value;
              });
              _formKey.currentState.reset();
            },
          ),
          Text(
            'Individual',
            style: TextStyle(fontSize: 17),
          ),
          Radio(
            activeColor: Colors.cyan,
            value: UserType.Individual,
            groupValue: _userType,
            onChanged: (UserType value) {
              setState(() {
                _userType = value;
              });
              _formKey.currentState.reset();
            },
          ),
        ],
      ),
    );
  }

  // MAINSHEET

  Widget mainSheet() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: screenSize * 0.67,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.cyan, width: 4),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: _form());
  }

  // FORM

  Widget _form() {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _nameInput(),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _userType == UserType.Business
                  ? _businessType()
                  : SizedBox(
                      height: screenSize * 0.004,
                    ),
              _userType == UserType.Business
                  ? SizedBox(
                      height: screenSize * 0.02,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              // Container(
              //   // padding: const EdgeInsets.all(0),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(child: _stateType()),
              //       SizedBox(width: 5),
              //       Expanded(child: _cityType())
              //     ],
              //   ),
              // ),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _emailDisplay(),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _phoneDisplay(),
              SizedBox(
                height: screenSize * 0.03,
              ),
            ]));
  }

  // NAME INPUTFIELD

  Widget _nameInput() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            _userType == UserType.Business ? Icons.store : Icons.account_circle,
            color: Colors.cyan,
          ),
          focusColor: Colors.white,
          hoverColor: Colors.white,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(30)),
          hintStyle: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 18),
          hintText:
              _userType == UserType.Business ? 'Business Name' : 'Individual'),
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      validator: (input) {
        return input.isEmpty ? 'Name is required' : null;
      },
      onChanged: (value) {
        _bName = value;
      },
      onSaved: (input) => _bName = input,
    );
  }

  // BUSINESS TYPE DROP DOWN MENU BUTTON

  Widget _businessType() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: DropdownButton<String>(
        hint: Text('Business Type'),
        isExpanded: true,
        value: bTypeDropdownValue,
        underline: Container(height: 0, color: Colors.white),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.cyan,
        ),
        iconSize: 25,
        elevation: 10,
        style: TextStyle(fontSize: 18, color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            bTypeDropdownValue = newValue;
            _bType = newValue;
          });
        },
        items: <String>[
          "FOOD",
          "HEALTHCARE",
          "HOME SERVICES",
          "RETAIL",
          "INDIVIDUAL SERVICES",
          "EDUCATION",
          "OTHER"
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Text(
                  "$value",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
          );
        }).toList(),
      ),
    );
  }

  // STATE DROP DOWN BUTTON

  // Widget _stateType() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.cyan, width: 2),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30)),
  //     padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
  //     child: DropdownButton<String>(
  //       isExpanded: true,
  //       hint: Text('State'),
  //       value: stateDropdownValue,
  //       underline: Container(height: 0, color: Colors.white),
  //       icon: Icon(
  //         Icons.arrow_drop_down,
  //         color: Colors.cyan,
  //       ),
  //       iconSize: 25,
  //       elevation: 10,
  //       style: TextStyle(fontSize: 18, color: Colors.black),
  //       onChanged: (String newValue) {
  //         setState(() {
  //           stateDropdownValue = newValue;
  //           _state = newValue;
  //         });
  //       },
  //       items: <String>['Business', 'One', 'Two', 'Free', 'Four']
  //           .map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // CITY DROP DOWN MWNU BUTTON

  // Widget _cityType() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(color: Colors.cyan, width: 2),
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30)),
  //     padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
  //     child: DropdownButton<String>(
  //       isExpanded: true,
  //       hint: Text('City'),
  //       value: cityDropdownValue,
  //       underline: Container(height: 0, color: Colors.white),
  //       icon: Icon(
  //         Icons.arrow_drop_down,
  //         color: Colors.cyan,
  //       ),
  //       iconSize: 25,
  //       elevation: 10,
  //       style: TextStyle(fontSize: 18, color: Colors.black),
  //       onChanged: (String newValue) {
  //         setState(() {
  //           cityDropdownValue = newValue;
  //           _city = newValue;
  //         });
  //       },
  //       items: <String>[
  //         "FOOD",
  //         "HEALTHCARE",
  //         "HOME SERVICES",
  //         "RETAIL",
  //         "INDIVIDUAL SERVICES",
  //         "EDUCATION",
  //         "OTHER"
  //       ].map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  // EMAIL INPUT FIELD

  Widget _emailDisplay() {
    return Container(
      // alignment: Alignment.topCenter,
      height: screenSize * 0.07,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 5),
        leading: Icon(
          Icons.verified_user,
          color: Colors.green,
        ),
        title: Text(
          _email,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        trailing: Icon(Icons.mail, color: Colors.cyan),
      ),
    );
  }

  // PHONE INPUT FIELD

  Widget _phoneDisplay() {
    return Container(
      alignment: Alignment.center,
      height: screenSize * 0.07,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 5),
        leading: Icon(
          Icons.verified_user,
          color: Colors.green,
        ),
        title: Text(
          _phoneNumber.replaceFirst('+91', ''),
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        trailing: Icon(Icons.phone_android, color: Colors.cyan),
      ),
    );
  }

  // FLOATING SUBMISSION BUTTON

  Widget _submitBtn() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.white,
      splashColor: Colors.cyan,
      isExtended: true,
      elevation: 10,
      onPressed: () {
        setState(() {
          _isRegistered = false;
        });
        Future.delayed(Duration(seconds: 3), () {
          _save();
        });
      },
      label: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Text('Register',
            style: TextStyle(color: Colors.cyan, fontSize: 18)),
      ),
    );
  }

  // SUBMISSION LOGIC

  void _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_bName.isNotEmpty &&
          _bType.isNotEmpty &&
          _email.isNotEmpty &&
          _phoneNumber.isNotEmpty) {
        if (_userType == UserType.Business) {
          BUser bUser =
              BUser(this._bName, this._bType, this._email, this._phoneNumber);
          List<String> bUserList = [
            bUser.bName,
            bUser.bType,
            bUser.email,
            bUser.phoneNumber
          ];
          storeBUser(bUserList);
        }
        if (_userType == UserType.Individual) {
          IndUser indUser =
              IndUser(this._bName, this._email, this._phoneNumber);
          List<String> indUserList = [
            indUser.name,
            indUser.email,
            indUser.phoneNumber
          ];
          storeIndUser(indUserList);
        }
      }
      setState(() {
        _isRegistered = true;
      });
      Navigator.of(context).pushReplacementNamed('/home');

      if (_bType == '') {
        showerror();
      }

      // await _databaseReference.push().set(contact.toJson());
    }
  }

  // STORE DATA

  storeBUser(List<String> bUser) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bUser', bUser);
  }

  storeIndUser(List<String> indUser) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('indUser', indUser);
  }

  //  SHOW PROGESS

  showProgress(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (_isRegistered == true) {
            Navigator.of(context).pop();
          }
          return AlertDialog(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              alignment: Alignment.center,
              height: screenSize * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                  ),
                  SizedBox(
                    height: screenSize * 0.01,
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.cyan),
                  )
                ],
              ),
            ),
          );
        });
  }

  //  SHOW ERROR DIALOG
  showerror() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'ERROR',
              style: TextStyle(color: Colors.cyan),
            ),
            content: Text(
              'All fields are required',
              style: TextStyle(color: Colors.red),
            ),
            actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.cyan,
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        _email = state.email.toString();
        _phoneNumber = state.phone.toString();
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              // customAppBar(),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _logo(),
              SizedBox(
                height: screenSize * 0.05,
              ),
              _userTypeRadio(),
              mainSheet()
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _submitBtn(),
        );
      },
    );
  }
}
