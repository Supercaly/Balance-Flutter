
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';
import 'package:balance_app/res/colors.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/widgets/custom_number_form_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/onboarding_bloc.dart';

/// Third intro screen
///
/// This Widget represents the third of the intro
/// screens, his purpose is to ask the user his age,
/// his gender and is weight.
/// The user can leave blank this info.
class GeneralInfoScreen extends StatefulWidget {
  /// Index of the screen
  final int screenIndex;
  final String age;
  final int gender;
  final String weight;

  GeneralInfoScreen(this.screenIndex, {
    this.age,
    this.gender,
    this.weight
  });

  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _genders = [BStrings.unknown_txt, BStrings.male_txt, BStrings.female_txt];
  int _genderIndex;

  @override
  void initState() {
    super.initState();
    _genderIndex = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingBloc, OnBoardingState>(
      condition: (_, current) =>  current is NeedToValidateState && current.index == widget.screenIndex,
      listener: (context, state) {
        final isValid = _formKey.currentState.validate();
        if (isValid) {
          _formKey.currentState.save();
          context.bloc<OnBoardingBloc>().add(ValidationSuccessEvent());
        }
        print("_GeneralInfoScreenState.build: General info are ${isValid? "valid": "invalid"}");
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
              Center(
                child: Image.asset(
                  "assets/images/eta.png",
                )
              ),
              SizedBox(height: 40),
              Text(
                BStrings.intro_general_title,
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomNumberFormField(
                        labelText: BStrings.age_txt,
                        initialValue: widget.age,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            try {
                              int age = int.parse(value);
                              if (age <= 0)
                                return BStrings.invalid_age_txt;
                              else if (age > 130)
                                return BStrings.too_old_error_txt;
                            } on FormatException catch(_) {
                              return BStrings.invalid_age_txt;
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue.isNotEmpty)
                            try {
                              PreferenceManager.updateUserInfo(age: int.parse(newValue));
                            } on FormatException catch(e) {
                              print("Some error occurred saving age data: ${e.message}");
                            }
                        },
                      ),
                      SizedBox(height: 8),
                      CustomDropdownFormField(
                        hint: BStrings.gender_txt,
                        value: _genderIndex,
                        onChanged: (newValue) {
                          setState(() => _genderIndex = newValue);
                        },
                        items: _genders.map((e) => CustomDropdownItem(text: e)).toList(),
                        openColor: Color(0xFFF4F6F9),
                        enabledColor: Colors.white,
                        enableTextColor: Color(0xFFBFBFBF),
                        elementTextColor: Color(0xFF666666),
                        enabledIconColor: BColors.colorPrimary,
                        validator: (_) => null,
                        onSaved: (newValue) => PreferenceManager.updateUserInfo(gender: newValue ?? 0),
                      ),
                      SizedBox(height: 8),
                      CustomNumberFormField(
                        labelText: BStrings.weight_txt,
                        decimal: true,
                        initialValue: widget.weight,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            try {
                              double weight = double.parse(value);
                              if (weight < 25.0)
                                return BStrings.too_light_error_txt;
                              else if (weight > 580.0)
                                return BStrings.too_heavy_error_txt;
                            } on FormatException catch(_) {
                              return BStrings.invalid_weight_txt;
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue.isNotEmpty)
                            try {
                              PreferenceManager.updateUserInfo(weight: double.parse(newValue));
                            } on FormatException catch(e) {
                              print("Some error occurred saving weight data: ${e.message}");
                            }
                        },
                      ),
                      SizedBox(height: 75),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}