import 'package:eagle_pixels/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/screen/home/my_profile.dart';
import 'package:eagle_pixels/screen/home/my_purchase_screen.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    MyProfileScreen(),
    HomeScreen(),
    MyPurchaseScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image(
              height: 23.98,
              image: AssetImage('images/my_purchase_icon_inactive.png'),
            ),
            activeIcon: Image(
              height: 23.98,
              image: AssetImage('images/my_purchase_icon.png'),
            ),
            label: 'My Purchase',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
