import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/home/my_profile.dart';
import 'package:flutter/material.dart';

import 'home/my_purchase_screen.dart';
import 'home_screen.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    MyProfileScreen(),
    AppController.to.isEngineer ? HomeScreen() : MyPurchaseScreen(),
    // MyPurchaseScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> get bars {
    List<BottomNavigationBarItem> bottomBar = [];
    bottomBar.add(BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 20.dynamic,
      ),
      label: 'My Profile',
    ));

    if (AppController.to.isEngineer) {
      // _widgetOptions = [
      //   MyProfileScreen(),
      //   HomeScreen(),
      //   MyPurchaseScreen(),
      // ];
      bottomBar.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 20.dynamic,
        ),
        label: 'Home',
        
      ));
    } else {
      // _widgetOptions = [
      //   MyProfileScreen(),
      //   MyPurchaseScreen(),
      // ];
      bottomBar.add(
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
      );
    }

    return bottomBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: this.bars,
        
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.dynamic,
        unselectedFontSize: 13.dynamic,
      ),
    );
  }
}
