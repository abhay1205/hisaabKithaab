import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paymng/arch/models/appState.dart';

class DrawerItems {
  String catName;
  String routeName;
  String subName;
  Widget icon;

  DrawerItems({this.catName, this.subName, this.routeName, this.icon});
}

class DrawerPage extends StatelessWidget {
  String _email = '';
  String _bName = '';
  String _bType = '';
  String _phoneNumber ='';

  final List<DrawerItems> items = [
    DrawerItems(catName: "Payment Manager", routeName: null, icon: null),
    DrawerItems(
      catName: "Manage Users",
      icon: Icon(
        Icons.account_circle,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Reports",
      icon: Icon(
        Icons.assessment,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Settings",
      icon: Icon(
        Icons.settings,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Rate the App",
      icon: Icon(
        Icons.star,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "About",
      icon: Icon(
        Icons.help,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Log Out",
      icon: Icon(
        Icons.arrow_back,
        color: Colors.cyan,
      ),
      routeName: '/ds',
    ),
  ];

  final double lsapce = 15;
  final double tspace = 25;
  final double iconspace = 20;
  final double fontsize = 18;

  Widget intro() {
    return Container(
      color: Colors.cyan[400],
      padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 15),
      child: ListTile(
        title: Text('$_bName', style: TextStyle(color: Colors.white, fontSize: 25),),
        isThreeLine: true,
        subtitle: Text('$_email\n${_phoneNumber.replaceFirst('+91', '')}', style: TextStyle(color: Colors.white),),
        trailing: Icon(Icons.verified_user, color: Colors.white, size: 35,),
      ),
    );
  }

  Widget listTile(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.cyan, width: 3),
      ),
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
        ),
        child: GestureDetector(
          child: ListTile(
            leading: items[index].icon == null ? Text('') : items[index].icon,
            title: Text(
              items[index].catName,
              style: TextStyle(fontSize: fontsize, color: Colors.cyan),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, items[index].routeName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        if(state.bUser.bName.toString().isNotEmpty){
           _bName = state.bUser.bName.toString();
          _bType = state.bUser.bType.toString();
          _email = state.bUser.email.toString();
          _phoneNumber = state.bUser.phoneNumber.toString(); 
        }
        else{
          _bName = state.indUser.name;
          _email = state.indUser.email;
          _phoneNumber = state.indUser.phoneNumber;
        }
        return Drawer(
          child: Container(
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Colors.amber[500], Colors.amber[400], Colors.amber[300], Colors.amber[200], Colors.amber[100],],
                //   stops: [0.0, 0.2, 0.6, 0.8, 0.9])
                ),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return index == 0 ? intro() : listTile(context, index);
                }),
          ),
        );
      },
    );
  }
}
