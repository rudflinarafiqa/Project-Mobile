import 'package:flutter/material.dart';
import 'package:meow_lastest/productScreen.dart';
import 'package:meow_lastest/cartScreen.dart';
import 'package:meow_lastest/profileScreen.dart';
import 'package:meow_lastest/user.dart';
import 'package:meow_lastest/paymentHistoryScreen.dart';
import 'package:meow_lastest/infoScreen.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> tabchildren;

  @override
  void initState() {
    super.initState();

    tabchildren = [
      InfoScreen(user: widget.user),
      ProductScreen(user: widget.user),
      CartScreen(user: widget.user),
      PaymentHistoryScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange[100],
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.info,),
            title: Text('Info'),
            backgroundColor: Colors.deepOrange[900],
          ),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_basket
            ),
            title: Text('Product'),
            backgroundColor: Colors.deepOrange[900],
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(
                'Cart',
              ),
              backgroundColor: Colors.deepOrange[900]),
          new BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              title: Text(
                'Payment History',
              ),
              backgroundColor: Colors.deepOrange[900]),
          new BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Me',
            ),
            backgroundColor: Colors.deepOrange[900],
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {}
      if (_currentIndex == 1) {}
      if (_currentIndex == 2) {}
      if (_currentIndex == 3) {}
      if (_currentIndex == 4) {}
    });
  }
}
