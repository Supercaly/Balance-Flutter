import 'package:balance_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'calibrate_device_screen.dart';
import 'home_screen.dart';
import 'measurements_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Index of the current page open
  int _currentIndex = 0;
  // List of pages titles
  List<String> _pageTitles = ["Home", "Measurements", "Calibrate Device"];
  // List of pages to display
  List<Widget> _pages = [HomeScreen(), MeasurementsScreen(), CalibrateDeviceScreen()];

  // Page View controller
  final PageController _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentIndex]),
        // Show the settings action if the current page is HomeScreen
        actions: _currentIndex == 0 ? [IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, "/settings_route")
        )] : null,
      ),
      body: WillPopScope(
        onWillPop: () => Future.sync(() {
          // When back button is pressed return to initial page or close the app
          if (_isCurrentPageInitial()) return true;
          _pageController.jumpToPage(_pageController.initialPage);
          setState(() => _currentIndex = 0);
          return false;
        }),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _pages
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: BColors.colorPrimary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (newIdx) => setState(() {
          // Set the current page to the selected and update the current index
          _pageController.jumpToPage(newIdx);
          _currentIndex = newIdx;
        }),
        items: [
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(title: Text("Measurements"), icon: Icon(Icons.near_me)),
          BottomNavigationBarItem(title: Text("Calibrate Device"), icon: Icon(Icons.calendar_today)),
        ],
      ),
    );
  }

  // Return [true] if the current page is the initial page, [false] otherwise
  bool _isCurrentPageInitial() => _pageController.page.round() == _pageController.initialPage;
}