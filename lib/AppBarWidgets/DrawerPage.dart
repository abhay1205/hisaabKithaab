import 'package:flutter/material.dart';

class DrawerItems {
  String catName;
  String routeName;
  String subName;
  Widget icon;

  DrawerItems({this.catName, this.subName, this.routeName, this.icon});
}

class DrawerPage extends StatelessWidget {
  final List<DrawerItems> items = [
    DrawerItems(catName: "Payment Manager", routeName: null, icon: null),
    DrawerItems(
      catName: "Rate the App",
      routeName: '/ds',
    ),
    DrawerItems(
      catName: "About",
      routeName: '/ds',
    ),
  ];

  final double lsapce = 15;
  final double tspace = 25;
  final double iconspace = 20;
  final double fontsize = 18;

  Widget intro() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 15),
        child: Row(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
            Text(
              "Abhay",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTile(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: lsapce, top: tspace),
        child: Center(
          child: Row(
            children: <Widget>[
              items[index].icon == null ? Text('') : items[index].icon,
              Padding(padding: EdgeInsets.only(right: iconspace)),
              Text(
                items[index].catName,
                style: TextStyle(fontSize: fontsize),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, items[index].routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return index == 0 ? intro() : listTile(context, index);
          }),
    );
  }
}
