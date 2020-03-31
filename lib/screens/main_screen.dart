import 'package:balance_app/res/colors.dart';
import 'package:balance_app/res/string.dart';
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
          NavigationItem(icon: Icon(Icons.home), text: Text("Home")),
          NavigationItem(icon: Icon(Icons.list), text: Text("Tests")),
          NavigationItem(icon: Icon(Icons.settings), text: Text("Settings")),
        ],
        onTap: (newIdx) => setState(() => _currentIndex = newIdx),
      ),
    );
  }
}

class GoogleBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color rectangleColor;
  final List<NavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  GoogleBottomNavigationBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor = Colors.white,
    this.selectedColor = BColors.colorPrimary,
    this.unselectedColor = BColors.textColor,
    this.rectangleColor = const Color(0xffe8e7ff),
  }): assert(items != null),
    assert(items.length >= 2),
    assert(0 <= currentIndex && currentIndex < items.length),
    super(key: key);

  @override
  _GoogleBottomNavigationBarState createState() => _GoogleBottomNavigationBarState();
}

class _GoogleBottomNavigationBarState extends State<GoogleBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      padding: EdgeInsets.only(left: 24, top: 6, right: 24, bottom: 6),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.items.map((item) {
          final itemIdx = widget.items.indexOf(item);
          return Material(
            color: widget.backgroundColor,
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                if (widget.currentIndex != itemIdx) {
                  widget.onTap.call(itemIdx);
                }
              },
              child: _buildItem(item, widget.currentIndex == itemIdx),
            ),
          );
        }).toList()
      )
    );
  }

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      width: isSelected ? 122 : 50,
      height: double.maxFinite,
      decoration: isSelected ? BoxDecoration(
        color: widget.rectangleColor,
        borderRadius: BorderRadius.circular(90)
      ): null,
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: 24,
                    color: isSelected ? widget.selectedColor: widget.unselectedColor
                  ),
                  child: item.icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: isSelected ?
                    DefaultTextStyle.merge(
                      style: TextStyle(
                        color: widget.selectedColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                      child: item.text
                    ): Container(),
                )
              ],
            ),
          ]
        ),
      )
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text text;

  NavigationItem({this.icon, this.text});
}
