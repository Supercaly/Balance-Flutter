
import 'package:balance_app/manager/user_info_manager.dart';
import 'package:balance_app/res/colors.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:balance_app/widgets/custom_checkbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

class SightScreen extends StatefulWidget {
  @override
  _SightScreenState createState() => _SightScreenState();
}

class _SightScreenState extends State<SightScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sightDefects = ["Miopia", "Presbiopia", "Ipermetropia"];
  final _hearDefects = ["none", "light", "moderata", "severa", "profonda"];
  List<bool> _selectedSightProblem;
  int _hearIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 5,
      listener: (context, state) {
        final isValid = _formKey.currentState.validate();
        if (isValid) {
          _formKey.currentState.save();
          context.bloc<IntroBloc>().add(ValidationSuccessEvent());
        }
        print("_SightScreenState.build: Sight and Hearing info are ${isValid? "valid": "invalid"}");
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Text(
                  "Difetti visivi",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                CheckboxGroupFormField(
                  items: _sightDefects,
                  value: _selectedSightProblem,
                  onChanged: (value) => setState(() => _selectedSightProblem = value),
                  validator: (value) => null,
                  onSaved: (newValue) => UserInfoManager.update(sightProblems: newValue?? List.filled(3, false)),
                ),
                SizedBox(height: 40),
                Text(
                  "Difetti Uditivi",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                CustomDropdownFormField(
                  hint: "Ipermetropia",
                  value: _hearIndex,
                  onChanged: (newValue) {
                    setState(() => _hearIndex = newValue);
                  },
                  items: _hearDefects.map((e) => CustomDropdownItem(text: e.toString())).toList(),
                  openColor: Color(0xFFF4F6F9),
                  enabledColor: Colors.white,
                  enableTextColor: Color(0xFFBFBFBF),
                  elementTextColor: Color(0xFF666666),
                  enabledIconColor: BColors.colorPrimary,
                  validator: (_) => null,
                  onSaved: (newValue) => UserInfoManager.update(hearingProblems: newValue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
