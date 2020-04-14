
import 'package:flutter/material.dart';
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/widgets/custom_checkbox.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

/// Fifth intro screen
///
/// This Widget represents the fifth of the intro
/// screens, his purpose is to ask the user if he
/// had some trauma like broken bones, head trauma
/// or other.
/// The user can leave blank this info.
class TraumaScreen extends StatefulWidget {
  @override
  _TraumaScreenState createState() => _TraumaScreenState();
}

class _TraumaScreenState extends State<TraumaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otherTrauma = ["Fratture", "Operazioni agli arti", "Cadute", "Distorsioni", "Trauma cranici"];
  List<bool> _selectedTrauma;

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 4,
      listener: (context, state) {
        final isValid = _formKey.currentState.validate();
        if (isValid) {
          _formKey.currentState.save();
          context.bloc<IntroBloc>().add(ValidationSuccessEvent());
        }
        print("_TraumaScreenState.build: Trauma info are ${isValid? "valid": "invalid"}");
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                "Altri precedenti traumatici?",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Form(
                key: _formKey,
                child: CheckboxGroupFormField(
                  items: _otherTrauma,
                  value: _selectedTrauma,
                  onChanged: (value) {
                    setState(() =>_selectedTrauma = value);
                  },
                  validator: (value) => null,
                  onSaved: (newValue) => PreferenceManager.update(
                    otherTrauma: newValue?? List.filled(5, false)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
