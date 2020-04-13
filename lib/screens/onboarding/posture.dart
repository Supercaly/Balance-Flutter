
import 'package:balance_app/manager/user_info_manager.dart';
import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:balance_app/widgets/custom_checkbox.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

class PostureScreen extends StatefulWidget {
  @override
  _PostureScreenState createState() => _PostureScreenState();
}

class _PostureScreenState extends State<PostureScreen> {
  final _formKey = GlobalKey<FormState>();
  List<bool> _selectedPosture;
  bool _problemsInFamily = false;
  bool _useOfDrugs = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 3,
      listener: (context, state) {
        final isValid = _formKey.currentState.validate();
        if (isValid) {
          _formKey.currentState.save();
          context.bloc<IntroBloc>().add(ValidationSuccessEvent());
        }
        print("_PostureScreenState.build: Posture info are ${isValid? "valid": "invalid"}");
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
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
                CheckboxGroupFormField(
                  items: [
                    "Scogliosi",
                    "Cifosi",
                    "Lordosi",
                  ],
                  validator: (value) => null,
                  onSaved: (newValue) => UserInfoManager.update(posturalProblems: newValue ?? List.filled(3, false)),
                  value: _selectedPosture,
                  onChanged: (value) => setState(() {
                    _selectedPosture = value;
                  }),
                ),
                SizedBox(height: 24),
                PlainCheckboxFormField(
                  child: Text(
                    "Sono presenti problemi posturali in famiglia?",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  value: _problemsInFamily,
                  onChanged: (value) => setState(() => _problemsInFamily = value),
                  validator: (value) => null,
                  onSaved: (newValue) => UserInfoManager.update(problemsInFamily: newValue),
                ),
                SizedBox(height: 20),
                PlainCheckboxFormField(
                  child: Text(
                    "Uso di medicinali che possono interferire con l'equilibrio",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  value: _useOfDrugs,
                  onChanged: (value) => setState(() => _useOfDrugs = value),
                  validator: (value) => null,
                  onSaved: (newValue) => UserInfoManager.update(useOfDrugs: newValue),
                ),
                SizedBox(height: 80)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
