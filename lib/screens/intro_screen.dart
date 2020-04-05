
import 'package:balance_app/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balance_app/res/colors.dart';
import 'package:balance_app/widgets/dots_indicator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

import 'onboarding/height.dart';
import 'onboarding/welcome.dart';

/// This class show an introduction when the app is first open.
class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _isNextBtnEnable = true;
  List<Color> _pageColors = [
    BColors.colorPrimary,
    Color(0xffF2BB25),
    Color(0xFF8ED547),
    Color(0xFFC95E4B),
    Color(0xFF36836C),
    Color(0xFF398AA7),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntroBloc(),
      child: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: true,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  color: _pageColors[_currentPage],
                  child: BlocListener<IntroBloc, IntroState>(
                    condition: (_, current) => current is ValidationResultState,
                    listener: (context, state) {
                      // If the page is valid move to next page
                      if ((state as ValidationResultState).isValid)
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.ease
                        );
                      print("è valido: ${(state as ValidationResultState).isValid}");
                    },
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (newPage) =>
                        setState(() {
                          _currentPage = newPage;
                          if (newPage == 1)
                            _isNextBtnEnable = false;
                        }),
                      children: [
                        WelcomeScreen(),
                        HeightScreen((isEnable) => setState(() => _isNextBtnEnable = isEnable)),
                        Center(child: Text("Hola2")),
                        Center(child: Text("Hola3")),
                        Center(child: Text("Hola4")),
                        Center(child: Text("Hola5")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            color: _pageColors[_currentPage],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DotsIndicator(
                  size: 6,
                  selected: _currentPage,
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 270),
                  height: 64,
                  child: Row(children: <Widget>[
                    (_currentPage != 0 && _currentPage != 1)? FlatButton(
                      textColor: Colors.white,
                      onPressed: () => print("Skippooo"),
                      child: Text("Skip"),
                    ): SizedBox(),
                    NextButton(
                      onTap: () => BlocProvider.of<IntroBloc>(context).add(NeedToValidateEvent()),
                      isEnable: _isNextBtnEnable,
                      isDone: _currentPage == 5,
                      backgroundColor: (_currentPage == 0)? BColors.colorAccent: BColors.colorPrimary,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}