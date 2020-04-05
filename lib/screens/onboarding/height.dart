
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/intro_bloc.dart';

/// Second of the intro screens
///
/// This Widget represents the second of the intro
/// screens, his purpose is to ask the user his
/// height letting him know why ke need such
/// information.
class HeightScreen extends StatefulWidget {
  final ValueChanged<bool> callback;

  HeightScreen(this.callback);

  @override
  HeightScreenState createState() => HeightScreenState();
}

class HeightScreenState extends State<HeightScreen> {
  TextEditingController _heightTextController = TextEditingController();
  bool canGoNext = false;

  @override
  void initState() {
    super.initState();

    _heightTextController.addListener(() {
      if (_heightTextController.text.isNotEmpty && !canGoNext) {
        canGoNext = true;
        widget.callback(true);
      } else if (_heightTextController.text.isEmpty && canGoNext) {
        canGoNext = false;
        widget.callback(false);
      }
    });
  }

  @override
  void dispose() {
    _heightTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroBloc, IntroState>(
      condition: (_, current) => current is NeedToValidateState,
      listener: (context, state) {
        print("Devo validare height");
        context.bloc<IntroBloc>().add(ValidationResultEvent(false));
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            InkWell(
              // TODO: 05/04/20 Remove this
              onTap: () => widget.callback(true),
              child: Center(
                child: IconTheme(
                  data: IconThemeData(
                    size: 150,
                  ),
                  child: Icon(Icons.accessibility)
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Tell us your height",
                style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et risus metus ut vel mattis.",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _heightTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Height",
                  errorText: _heightTextController.text.length > 3? "Errorino": null,
                  filled: true,
                  fillColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
