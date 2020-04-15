
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:balance_app/screens/onboarding/height.dart';
import 'package:balance_app/widgets/custom_number_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/onboarding_bloc.dart';

void main() {

  testWidgets("No initial value", (tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnBoardingBloc.create(),
          child: HeightScreen(
            0,
            (_) {},
          ),
        ),
      )
    );

    final heightEditTextFinder = find.text("Height");
    expect(heightEditTextFinder, findsOneWidget);
  });

  testWidgets("Initial value", (tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnBoardingBloc.create(),
          child: HeightScreen(
            0,
            (_) {},
            height: "123.4",
          ),
        ),
      )
    );

    final heightEditTextFinder = find.text("123.4");
    expect(heightEditTextFinder, findsOneWidget);
  });

  testWidgets("Write some value", (tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => OnBoardingBloc.create(),
          child: HeightScreen(
            0,
            (e) {
              prints(e);
            },
          ),
        ),
      )
    );

    await tester.enterText(find.byType(CustomNumberFormField), "105.0");
    expect(find.text("105.0"), findsOneWidget);
  });
}