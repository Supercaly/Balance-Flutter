
import 'package:balance_app/res/string.dart';
import 'package:balance_app/widgets/google_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'measurements_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _initialPage = 0;
  // Index of the current page open
  int _currentIndex;
  List<Widget> _pages;
  List<String> _titles;

  @override
  void initState() {
    _currentIndex = _initialPage;
    _pages = [HomeScreen(), MeasurementsScreen(), SettingsScreen()];
    _titles = BStrings.navigation_titles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
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
          GoogleBottomNavigationItem(icon: Icon(Icons.home), text: Text(_titles[0])),
          GoogleBottomNavigationItem(icon: Icon(Icons.list), text: Text(_titles[1])),
          GoogleBottomNavigationItem(icon: Icon(Icons.settings), text: Text(_titles[2])),
        ],
        onTap: (newIdx) => setState(() => _currentIndex = newIdx),
      ),
    );
  }
}