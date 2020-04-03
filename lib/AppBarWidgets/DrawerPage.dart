import 'package:flutter/material.dart';

class DrawerItems {
  String catName;
  String routeName;
  String subName;
  Widget icon;

  DrawerItems({this.catName, this.subName, this.routeName, this.icon});
}

class DrawerPage extends StatelessWidget {

  final String email;

  DrawerPage({this.email});

  final List<DrawerItems> items = [
    DrawerItems(catName: "Payment Manager", routeName: null, icon: null),
    DrawerItems(
      catName: "Manage Users",
      icon: Icon(Icons.account_circle, color: Colors.cyan,),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Reports",
      icon: Icon(Icons.assessment, color: Colors.cyan,),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Settings",
      icon: Icon(Icons.settings, color: Colors.cyan,),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Rate the App",
      icon: Icon(Icons.star, color: Colors.cyan,),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "About",
      icon: Icon(Icons.help, color: Colors.cyan,),
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "Log Out",
      icon: Icon(Icons.arrow_back, color: Colors.cyan,),
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
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 15),
        child: Row(
          children: <Widget>[
            // Align(
            //     alignment: Alignment.topLeft,
            //     child: CircleAvatar(
            //       radius: 45,
            //       backgroundColor: Colors.white,
            //     )),
            SizedBox(
              width: 20,
            ),
            Text(
              email,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTile(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(0),
      
      decoration: BoxDecoration(
        border: Border.all( color: Colors.cyan, width: 3),
      ),
      child: Card(
        color: Colors.white,
        elevation: 5,
        margin: EdgeInsets.only(left: 20, right:20, top: 10,),
        child: GestureDetector(
          child: ListTile(
            leading: items[index].icon == null ? Text('') : items[index].icon,
            title: Text(
              items[index].catName,
              style: TextStyle(fontSize: fontsize, color: Colors.cyan),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: lsapce, top: tspace),
          //   child: Center(
          //     child: Row(
          //       children: <Widget>[
          //
          //         Padding(padding: EdgeInsets.only(right: iconspace)),

          //       ],
          //     ),
          //   ),
          // ),
          onTap: () {
            Navigator.pushNamed(context, items[index].routeName);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
