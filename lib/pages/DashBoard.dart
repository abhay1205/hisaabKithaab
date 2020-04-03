import 'package:flutter/material.dart';
class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  double screenSize;
  final GlobalKey _formKey = GlobalKey<FormState>();
  var _userInfoMap;
  String dropdownValue;

  

  Widget _logo() {
    return Container(
      height: screenSize*0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/Logo.jpeg'),
          fit: BoxFit.contain,
          colorFilter: new ColorFilter.mode(Colors.red.withOpacity(0.6), BlendMode.dstATop),),
      ),
      child: Container(
        padding: EdgeInsets.only(top:20),
        alignment: Alignment.topCenter,
        child: Text('Hisaab Kitaab', 
        style: TextStyle(color: Colors.cyan, fontSize:50, fontWeight: FontWeight.w400))
      )

    );
  }

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

  Widget _nameInput() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.cyan,
                width: 2
              ),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.store,
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
          hintText: 'Business Name'),
      keyboardType: TextInputType.text,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      validator: (input) {
        return input.isEmpty ? 'Name is required' : null;
      },
      onSaved: (input) => _userInfoMap['businessName'] = input,
    );
  }

  Widget _businessType() {
    return Container(
      decoration: BoxDecoration(
         border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: DropdownButton<String>(
        hint: Text('Business Type'),
        isExpanded: true,
        value: dropdownValue,
        underline: Container(
          height: 0,
          color: Colors.white
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.cyan,
        ),
        iconSize: 25,
        elevation: 10,
        style: TextStyle(fontSize: 18, color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Business', 'One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _stateType() {
    return Container(
      decoration: BoxDecoration(
         border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('State'),
        value: dropdownValue,
         underline: Container(
          height: 0,
          color: Colors.white
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.cyan,
        ),
        iconSize: 25,
        elevation: 10,
        style: TextStyle(fontSize: 18, color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Business', 'One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _cityType() {
    return Container(
      decoration: BoxDecoration(
         border: Border.all(color: Colors.cyan, width: 2),
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text('City'),
        value: dropdownValue,
         underline: Container(
          height: 0,
          color: Colors.white
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.cyan,
        ),
        iconSize: 25,
        elevation: 10,
        style: TextStyle(fontSize: 18, color: Colors.black),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Business', 'One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _emailInput() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.cyan,
                width: 2
              ),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.email,
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
          hintText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      validator: (input) {
        return input.length == 10 ? 'Enter a valid number' : null;
      },
      onSaved: (input) => _userInfoMap['businessName'] = input,
    );
  }

  Widget _phoneInput() {
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.cyan,
                width: 2
              ),
              borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan, width: 2),
              borderRadius: BorderRadius.circular(30)),
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.phone_android,
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
          hintText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      validator: (input) {
        return input.length == 10 ? 'Enter a valid number' : null;
      },
      onSaved: (input) => _userInfoMap['businessName'] = input,
    );
  }

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
              _businessType(),
              SizedBox(
                height: screenSize * 0.02,
              ),
              Container(
                // padding: const EdgeInsets.all(0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: _stateType()),
                    SizedBox(width: 5),
                    Expanded(child: _cityType())
                  ],
                ),
              ),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _emailInput(),
              SizedBox(
                height: screenSize * 0.02,
              ),
              _phoneInput(),
              SizedBox(
                height: screenSize * 0.03,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: 150,
                  decoration: BoxDecoration(
                     border: Border.all(color: Colors.cyan, width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.cyan[400],
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            // customAppBar(),
            SizedBox(
              height: screenSize * 0.05,
            ),
            _logo(),
            SizedBox(
              height: screenSize * 0.05,
            ),
            mainSheet()
          ],
        ));
  }
}
