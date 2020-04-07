
import 'package:flutter/material.dart';
import 'package:balance_app/widgets/custom_number_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

class GeneralInfoScreen extends StatefulWidget {
  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) =>  current is NeedToValidateState && current.index == 2,
      listener: (context, state) {
        final isValid = _formKey.currentState.validate();
        context.bloc<IntroBloc>().add(ValidationResultEvent(isValid));
        print("GeneralInfoScreen.build: General info are ${isValid? "valid": "invalid"}");
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
                child: IconTheme(
                  data: IconThemeData(
                    size: 200,
                  ),
                  child: Icon(Icons.group),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Tell us more about you",
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
                        labelText: "Age",
                        validator: (value) {
                          if (value.isNotEmpty) {
                            try {
                              int age = int.parse(value);
                              if (age <= 0)
                                return "Invalid Age!";
                              else if (age > 130)
                                return "You're too old!";
                            } on FormatException catch(_) {
                              return "Invalid Age!";
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          // TODO: 06/04/20 Update the model
                        },
                      ),
                      SizedBox(height: 0),
                      DropdownButton(
                        items: [0,1,2].map((e) => DropdownMenuItem(
                          child: Text(e.toString()),
                          value: e,
                        )).toList(),
                        onChanged: (_) {},
                        hint: Text("Gender"),
                      ),
                      SizedBox(height: 0),
                      CustomNumberFormField(
                        labelText: "Weight",
                        decimal: true,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            try {
                              double weight = double.parse(value);
                              if (weight <= 0)
                                return "Invalid Age!";
                              else if (weight > 130)
                                return "You're too old!";
                            } on FormatException catch(_) {
                              return "Invalid Age!";
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          // TODO: 06/04/20 Update the model
                        },
                      ),
                      SizedBox(height: 70),
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
