
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnBoardingScreenSate();
}

class _OnBoardingScreenSate extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<Widget> _pages = [
    Text("aa"),
    Text("bb"),
    Text("cc"),
  ];
  final List<Color> _colors = [Colors.red, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              color: _colors[_currentPage],
              child: SafeArea(
                // TODO: 02/04/20 Remove page view... use _pages[_currentPage]
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() => _currentPage = page);
                  },
                  children: _pages,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: null,
                        child: Text("Skip"),
                      ),
                      Container(
                        width: 64,
                        height: 64,
                        child: FloatingActionButton(
                          onPressed: null,
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ],
                  )
                ]
              ),
            )
          ],
        ),
      )
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
    duration: Duration(milliseconds: 200),
    margin: EdgeInsets.symmetric(horizontal: 6.0),
    height: 8.0,
    width: isActive ? 30.0 : 8.0,
    decoration: BoxDecoration(
      color: isActive ? Colors.white : Colors.white38,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );
}