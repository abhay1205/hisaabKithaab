// THIS IS THE LOGIN PAGE BASED ON MOBILE NUMBER AUTHENTICATION AND GOOGLE SIGN IN
// FROM HERE MOBILE NUMBER AND GOOGLE EMAIL ID ARE STORED LOCALLY USING SHAREDPREFRENCES
// REDUX ARCHITECTURE IS USED TO BUILT THE LOGIN LOGICS

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paymng/arch/AuthService.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String _phoneNo, _verificationID;
  dynamic _email, _emailLinkedPhoneNumber, _idToken;
  bool _numVerified = false, _emailVerified = false;

  static double screenSize;

  // ALL LOGIN LOGICS

  // MOBILE NUMBER LOGIN LOGIC

  Future<void> _verifyPhone(phoneNo) async {
    try {
      final PhoneVerificationCompleted verified = (AuthCredential authResult) {
        AuthService().signIn(authResult);
      };

      final PhoneVerificationFailed verificationFailed =
          (AuthException authException) {
        Text('${authException.message}');
      };
      final PhoneCodeSent smsSent = (String verId, [int forceSend]) {
        _verificationID = verId;
      };
      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this._verificationID = verId;
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeout);
      _storeUserNumber(_phoneNo);
      setState(() {
        _numVerified = true;
      });

      print(_phoneNo);
    } catch (e) {
      Future.delayed(Duration(seconds: 2), () {
        showError(e.toString());
        print('Mobile Auth Error');
      });
      _numVerified = false;
    }
  }

  // GOOGLE SIGN IN LOGIC

  Future<FirebaseUser> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final FirebaseUser user =
          (await _auth.signInWithCredential(authCredential)).user;
      assert(user.email != null);
      assert(user.displayName != null);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentuser = await _auth.currentUser();
      assert(user.uid == currentuser.uid);
      _email = user.email;
      _emailLinkedPhoneNumber = user.phoneNumber;
      _storeUserEmail(_email, _emailLinkedPhoneNumber);
      print(_email);
      setState(() {
        _emailVerified = true;
      });
      if (user.email != null) {
        Navigator.pushReplacementNamed(context, '/dash');
      }
      return user;
    } catch (e) {
      Future.delayed(Duration(seconds: 1), () {
        showError(e.toString());
        _emailVerified = false;
      });
    }
  }

  // LOCAL DATA STORAGE LOGIC

  void _storeUserEmail(email, emailLinkNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('email-linked-number', emailLinkNumber);
  }

  void _storeUserNumber(number) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('number', number);
  }

  // ALL THE WIDGETS IN ORDER FROM TOP TO BOTTOM

  // APP BAR

  Widget _customAppBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: screenSize * 0.09,
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Hisaab ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
            Text("Kitaab",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // APP LOGO

  Widget _logo() {
    return Container(
      child: Image.asset(
        'asset/Logo.jpeg',
        height: screenSize * 0.31,
      ),
    );
  }

  // FORM

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 50),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _phoneInput(),
                        SizedBox(height: screenSize * 0.05),
                        _phoneLoginButton(_phoneNo),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: screenSize * 0.04,
              ),

//  GOOGLE LOGIN BUTTON
              Opacity(
                opacity: _numVerified == true ? 1 : 0.4,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                        child: Text(
                          '2',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(flex: 3, child: _googleButton())
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // MOBILE NUMBER INPUT FIELD

  Widget _phoneInput() {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan[400], width: 2),
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan[400], width: 2),
                borderRadius: BorderRadius.circular(30)),
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(
              Icons.phone_android,
              color: Colors.cyan,
            ),
            focusColor: Colors.cyan[400],
            hoverColor: Colors.cyan[400],
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30)),
            hintStyle: TextStyle(
                color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 18),
            hintText: 'Mobile Number'),
        keyboardType: TextInputType.phone,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        validator: (input) {
          return input.length != 10 ? 'Enter a valid number' : null;
        },
        onChanged: (value) {
          setState(() {
            this._phoneNo = '+91' + value;
          });
        },
        onSaved: (input) => _phoneNo = '+91' + input,
      ),
    );
  }

  // MOBILE LOGIN BUTTON

  Widget _phoneLoginButton(dynamic phoneNumber) {
    return OutlineButton(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      borderSide: BorderSide(color: Colors.cyan, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      splashColor: Colors.cyan,
      highlightedBorderColor: Colors.cyan,
      color: Colors.white,
      child: Text(
        'Verify',
        style: TextStyle(
            color: Colors.cyan, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Future.delayed(Duration(seconds: 2), () {
            _verifyPhone(phoneNumber);
          });
          // if((_numVerified == false)){
          //   showProgress('Verifying Number');
          // }
        }
      },
    );
  }

  //  GOOGLE LOGIN BUTTON

  Widget _googleButton() {
    return Container(
      // margin: EdgeInsets.only(left: 160, right: 50),
      padding: EdgeInsets.only(left: 40),
      child: GoogleSignInButton(
        text: 'Google Sign In',
        borderRadius: 20,
        darkMode: false,
        onPressed: () {
          _numVerified == true ? _signInWithGoogle() : null;
          if (_emailVerified == false) {
            showProgress('Sigining In');
          }
        },
      ),
    );
  }

  // SHOW PROGRESS

  showProgress(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (message == 'Verifying Number' && _numVerified == true) {
            Navigator.pop(context);
          }
          if (message == 'Sigining In' && _emailVerified == true) {
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

  // ERROR WIDGET

  showError(String errMsg) {
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
              'An error must encountered, check your internet connection',
              style: TextStyle(color: Colors.cyan),
            ),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.cyan,
                child: Text(
                  "Try Again",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  // AD CONTAINER

  Widget adConatiner() {
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      height: screenSize * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Text("Ad"),
    );
  }

  // FOOTER

  Widget footer() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        // height: screenSize * 0.040,
        decoration: BoxDecoration(
            color: Colors.cyan[400],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("developed by abhay1205",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET BUILDER

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
          // scrollDirection: Axis.horizontal,
          children: <Widget>[
            _customAppBar(),
            _logo(),
            SizedBox(
              height: screenSize * 0.0245,
            ),
            _form(),
            SizedBox(
              height: screenSize * 0.04,
            ),
            // _googleButton(),
            SizedBox(
              height: screenSize * 0.057,
            ),
            adConatiner(),
            // footer()
          ]),
    );
  }
}
