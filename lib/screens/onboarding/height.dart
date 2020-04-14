
import 'package:flutter/material.dart';
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/widgets/custom_number_form_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

/// Second intro screen
///
/// This Widget represents the second of the intro
/// screens, his purpose is to ask the user his
/// height letting him know why ke need such
/// information; the user cannot skip this step.
class HeightScreen extends StatefulWidget {
  final ValueChanged<bool> enableNextBtnCallback;

  HeightScreen(this.enableNextBtnCallback);

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _canGoNext = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 1,
      listener: (context, state) {
        // Validate and save height data
        bool isValid = _formKey.currentState.validate();
        if (isValid) {
          _formKey.currentState.save();
          /*
           * All the required data are stored... mark the
           * first launch as done so we don't ask this data anymore
           */
          PreferenceManager.firstLaunchDone();
          context.bloc<IntroBloc>().add(ValidationSuccessEvent());
        }
        print("_HeightScreenState.build: Height data is ${isValid? 'valid': 'invalid'}");
      },
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //SizedBox(height: 50),
              Center(
                child: IconTheme(
                  data: IconThemeData(
                    size: 150,
                  ),
                  child: Icon(Icons.accessibility)
                ),
              ),
              SizedBox(height: 100),
              Text(
                "Tell us your height",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 18),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et risus metus ut vel mattis.",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Form(
                  key: _formKey,
                  child: CustomNumberFormField(
                    labelText: "Height",
                    suffix: "cm",
                    onChanged: (isNotEmpty) {
                      // Enable/Disable the next button if the text field is empty
                      if (isNotEmpty && !_canGoNext) {
                        _canGoNext = true;
                        widget.enableNextBtnCallback(true);
                      } else if (!isNotEmpty && _canGoNext) {
                        _canGoNext = false;
                        widget.enableNextBtnCallback(false);
                      }
                    },
                    validator: (value) {
                      try {
                        double height = double.parse(value);
                        if (height < 50)
                          return "You're too short!";
                        else if (height > 240)
                          return "You're too tall!";
                        else
                          return null;
                      } on FormatException catch(_) {
                        return "Invalid height!";
                      }
                    },
                    onSaved: (newValue) {
                      try {
                        PreferenceManager.update(height: double.parse(newValue));
                      } on FormatException catch(e) {
                        print("Some error occurred saving height data: ${e.message}");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 64)
            ],
          ),
        ),
      ),
    );
  }
}
