import 'package:flutter/material.dart';
import 'package:paymng/AppBarWidgets/DrawerPage.dart';
import 'package:paymng/TransactionPagesView/TransactionList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Payment Mangeger", style: TextStyle(color: Colors.white)),
        bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            controller: _tabController,
            tabs: [
              Text("Paytm",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("UPI", style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("G-Pay",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("PhonePe",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("Debit Cards",
                  style: TextStyle(color: Colors.white, fontSize: 20))
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TransactionList(),
          TransactionList(),
          TransactionList(),
          TransactionList(),
          TransactionList(),
        ],
      ),
      drawer: DrawerPage(),
    );
  }
}
