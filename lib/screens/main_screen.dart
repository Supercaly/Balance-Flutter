import 'package:balance_app/res/colors.dart';
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';

import 'calibrate_device_screen.dart';
import 'home_screen.dart';
import 'measurements_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _initialPage = 0;
  // Index of the current page open
  int _currentIndex;
  List<Widget> _pages;

  @override
  void initState() {
    _currentIndex = _initialPage;
    _pages = [HomeScreen(), MeasurementsScreen(), CalibrateDeviceScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BStrings.navigation_titles[_currentIndex]),
        // Show the settings action if the current page is HomeScreen
        actions: _currentIndex == _initialPage ? [IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, "/settings_route")
        )] : null,
      ),
      body: WillPopScope(
        onWillPop: () => Future.sync(() {
          // When back button is pressed return to initial page or close the app
          if (_currentIndex == _initialPage) return true;
          setState(() => _currentIndex = _initialPage);
          return false;
        }),
        child: _pages[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: BColors.colorPrimary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (newIdx) => setState(() {
          // Set the current page to the selected and update the current index
          //_pageController.jumpToPage(newIdx);
          setState(() => _currentIndex = newIdx);
        }),
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text("Measurements"), icon: Icon(Icons.near_me)),
          BottomNavigationBarItem(title: Text("Calibrate Device"), icon: Icon(Icons.calendar_today)),
        ],
      ),
    );
  }
}