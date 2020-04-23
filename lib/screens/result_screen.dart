
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/floor/test_database_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balance_app/bloc/result_bloc.dart';

import 'package:balance_app/widgets/result_features_items.dart';
import 'package:balance_app/widgets/result_info_item.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the resultId from the arguments
    final Test test = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: BlocProvider(
        create: (context) => ResultBloc.create(
          Provider.of<MeasurementDatabase>(context, listen: false),
          test?.id
        ),
        child: BlocConsumer<ResultBloc, ResultState>(
          listenWhen: (_, current) => current is ResultError,
          listener: (context, state) {
            Scaffold.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text("An unexpected error occurred!"),
            ));
          },
          builder: (context, state) {
            // Display the loading screen
            if (state is ResultLoading)
              return _loadingScreen(context, test);
            // Display the data screen
            else
              return _successScreen(context, test, state is ResultSuccess? state: null);
          },
        ),
      ),
    );
  }

  /// Build the loading screen
  Widget _loadingScreen(BuildContext context, Test test) => Scaffold(
    appBar: AppBar(
      title: Text("Test ${test?.id}"),
      elevation: 0,
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Result info card and appbar overflow
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(bottom: 26),
                color: Theme.of(context).primaryColor,
              ),
            ),
            // Result info card
            ResultInfoItem(test)
          ]
        ),
        Expanded(
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              child: CircularProgressIndicator()
            ),
          ),
        )
      ],
    )
  );

  /// Build the screen with data
  Widget _successScreen(
    BuildContext context,
    Test test,
    ResultSuccess success
  ) => CustomScrollView(slivers: <Widget>[
    SliverAppBar(
      title: Text("Test ${test?.id}"),
      floating: false,
    ),
    SliverList(
      delegate: SliverChildListDelegate.fixed([
        // Result info card and appbar overflow
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(bottom: 26),
                color: Theme.of(context).primaryColor,
              ),
            ),
            // Result info card
            ResultInfoItem(test),
          ]
        ),
        ResultFeaturesItems(success?.measurement),
      ])
    )
  ]);
}
