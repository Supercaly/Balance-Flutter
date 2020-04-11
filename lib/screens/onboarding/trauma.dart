
import 'package:balance_app/bloc/intro_bloc.dart';
import 'package:balance_app/widgets/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraumaScreen extends StatefulWidget {
  @override
  _TraumaScreenState createState() => _TraumaScreenState();
}

class _TraumaScreenState extends State<TraumaScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<CheckboxGroupState> _traumaKey = GlobalKey<CheckboxGroupState>();

    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState && current.index == 4,
      listener: (context, state) {
        print("TraumaScreen.build: selected: ${_traumaKey.currentState.selected}");
        context.bloc<IntroBloc>().add(ValidationSuccessEvent());
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
              CheckboxGroup(
                key: _traumaKey,
                labels: [
                  "Fratture",
                  "Operazioni agli arti",
                  "Cadute",
                  "Distorsioni",
                  "Trauma cranici",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
