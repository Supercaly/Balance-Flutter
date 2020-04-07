
import 'package:flutter/material.dart';
import 'package:balance_app/widgets/checkbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

class SightScreen extends StatefulWidget {
  @override
  _SightScreenState createState() => _SightScreenState();
}

class _SightScreenState extends State<SightScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 5,
      listener: (context, state) {
        print("_SightScreenState.build: ");
        context.bloc<IntroBloc>().add(ValidationResultEvent(true));
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
                "Difetti visivi",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              CheckboxGroup(
                labels: [
                  "Miopia",
                  "Presbiopia",
                  "Ipermetropia"
                ],
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
              DropdownButton(
                items: [0,1,2,3,4].map((e) => DropdownMenuItem(
                  child: Text(e.toString()),
                  value: e,
                )).toList(),
                onChanged: (_) {},
                hint: Text("Ipoacusia"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
