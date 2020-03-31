import 'package:balance_app/res/string.dart';
import 'package:balance_app/widgets/google_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
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
          onPressed: () => Navigator.pushNamed(context, Routes.settings)
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
      bottomNavigationBar: GoogleBottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          GoogleBottomNavigationItem(icon: Icon(Icons.home), text: Text("Home")),
          GoogleBottomNavigationItem(icon: Icon(Icons.list), text: Text("Tests")),
          GoogleBottomNavigationItem(icon: Icon(Icons.settings), text: Text("Settings")),
        ],
        onTap: (newIdx) => setState(() => _currentIndex = newIdx),
      ),
    );
  }
}