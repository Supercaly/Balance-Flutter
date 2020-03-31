import 'package:balance_app/res/colors.dart';
import 'package:flutter/material.dart';

/// A custom implementation of a bottom navigation bar
///
/// This Widget implements a custom version of a bottom
/// navigation bar, inspired form the youtube video:
/// https://www.youtube.com/watch?v=jJPSKEEiN-E
class GoogleBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Color rectangleColor;
  final List<GoogleBottomNavigationItem> items;
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

  /// Build a widget for each navigation item
  ///
  /// Given a [GoogleBottomNavigationItem] and if it [isSelected]
  /// returns a Widget to display as navigation element
  Widget _buildItem(GoogleBottomNavigationItem item, bool isSelected) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 270),
      width: isSelected ? 122 : 50,
      height: double.maxFinite,
      decoration: isSelected ? BoxDecoration(
        color: widget.rectangleColor,
        borderRadius: BorderRadius.circular(90)
      ): null,
      child: Center(
        child: isSelected ? ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: 24,
                    color: widget.selectedColor
                  ),
                  child: item.icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: widget.selectedColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                    child: item.text
                  ),
                ),
              ],
            ),
          ]
        ): IconTheme(
          data: IconThemeData(
            size: 24,
            color: widget.unselectedColor
          ),
          child: item.icon,
        ),
      )
    );
  }
}

/// Class representing a single element of the [GoogleBottomNavigationBar]
class GoogleBottomNavigationItem {
  final Icon icon;
  final Text text;

  GoogleBottomNavigationItem({
    @required this.icon,
    @required this.text,
  }):assert(icon != null),
      assert(text != null);
}
