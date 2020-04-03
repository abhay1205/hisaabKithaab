import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paymng/arch/mobileAuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String phoneNo, verificationID;

  double screenSize;

  Widget customAppBar() {
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      Text('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceSend]) {
      verificationID = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationID = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
    _storeUserNumber(phoneNo);
  }

  Widget _logo() {
    return Container(
      child: Image.asset(
        'asset/Logo.jpeg',
        // cacheHeight: (MediaQuery.of(context).size.height *0.31).toInt(),
        height: screenSize * 0.31,
      ),
    );
  }

  Widget _phoneInput() {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 50),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
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
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  hintText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              validator: (input) {
                return input.length == 10 ? 'Enter a valid number' : null;
              },
              onChanged: (value) {
                setState(() {
                  this.phoneNo = value;
                });
              },
              onSaved: (input) => phoneNo = input,
            ),
            SizedBox(
              height: screenSize * 0.05,
            ),
            GestureDetector(
              onTap: () {
                verifyPhone(phoneNo);
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 110,
                ),
                alignment: Alignment.center,
                height: 42,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'Mobile Login',
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

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
      List<String> userInfo = [
        user.email.toString(),
        user.displayName.toString(),
        user.phoneNumber.toString(),
        user.getIdToken().toString(),
      ];
      _storeUserInfo(userInfo);
      if (user.email != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  Widget googleButton() {
    return Container(
      margin: EdgeInsets.only(left: 160, right: 50),
      child: GoogleSignInButton(
        text: 'Google Sign In',
        borderRadius: 20,
        darkMode: false,
        onPressed: () {
          _signInWithGoogle();
        },
      ),
    );
  }

  void _storeUserInfo(userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('info', userInfo);
    prefs.setString('user', userInfo[0]);
  }

  void _storeUserNumber(number) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('number', number);
  }

  showError(String errMsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errMsg),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget adConatiner() {
    return Container(
      color: Colors.amber,
      alignment: Alignment.center,
      height: screenSize * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Text("Ad"),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: <Widget>[
        customAppBar(),
        SizedBox(
          height: screenSize * 0.0,
        ),
        _logo(),
        SizedBox(
          height: screenSize * 0.0245,
        ),
        _phoneInput(),
        SizedBox(
          height: screenSize * 0.04,
        ),
        googleButton(),
        SizedBox(
          height: screenSize * 0.057,
        ),
        adConatiner(),
        SizedBox(height: screenSize * 0.1),
        footer()
      ]),
    );
  }
}
