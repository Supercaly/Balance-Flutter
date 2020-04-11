
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:balance_app/widgets/checkbox.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

class PostureScreen extends StatefulWidget {
  @override
  _PostureScreenState createState() => _PostureScreenState();
}

class _PostureScreenState extends State<PostureScreen> {
  GlobalKey<CheckboxGroupState> _postureKey = GlobalKey<CheckboxGroupState>();
  bool _problemsInFamily = false;
  bool _useOfDrugs = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 3,
      listener: (context, state) {
        print("_PostureScreenState.build: posture: ${_postureKey.currentState.selected}");
        context.bloc<IntroBloc>().add(ValidationSuccessEvent());
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hai problemi di postura?",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              CheckboxGroup(
                key: _postureKey,
                labels: [
                  "Scogliosi",
                  "Cifosi",
                  "Lordosi",
                ],
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  setState(() => _problemsInFamily = !_problemsInFamily);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "Sono presenti problemi posturali in famiglia?",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircularCheckBox(
                      value: _problemsInFamily,
                      onChanged: (value) => setState(() => _problemsInFamily = value),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      checkColor: Color(0xFFC95E4B),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() => _useOfDrugs = !_useOfDrugs);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "Uso di medicinali che possono interferire con l'equilibrio",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CircularCheckBox(
                      value: _useOfDrugs,
                      onChanged: (value) => setState(() => _useOfDrugs = value),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      checkColor: Color(0xFFC95E4B),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
