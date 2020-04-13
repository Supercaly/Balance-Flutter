
import 'package:flutter/material.dart';
import 'package:balance_app/bloc/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoRecapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text styles used by the widget
    final titleTextStyle = Theme.of(context).textTheme.subtitle2.copyWith(
      fontSize: 17,
    );
    final headlineTextStyle = Theme.of(context).textTheme.bodyText1;
    final valueTextStyle = Theme.of(context).textTheme.caption;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your personal info"),
      ),
      body: BlocProvider<UserInfoBloc>(
        create: (context) => UserInfoBloc.create(),
        child: BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            if (state is UserInfoLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            final userInfo = (state as UserInfoSuccess).value;
            // TODO: 13/04/20 Add method to convert from UserInfo to strings
            return ListView(
              children: <Widget>[
                // General Info Card
                Card(
                  margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "General".toUpperCase(),
                          style: titleTextStyle,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Age",
                              style: headlineTextStyle,
                            ),
                            Text(
                              userInfo?.age.toString(),
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Gender",
                              style: headlineTextStyle,
                            ),
                            Text(
                              userInfo?.gender == 0? "unknown": userInfo?.gender == 1? "male": "female",
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Height",
                              style: headlineTextStyle,
                            ),
                            Text(
                              "${userInfo.height} cm",
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Weight",
                              style: headlineTextStyle,
                            ),
                            Text(
                              "${userInfo.weight} Kg",
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Health Info Card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Health".toUpperCase(),
                          style: titleTextStyle,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Postural problems",
                              style: headlineTextStyle,
                            ),
                            Text(
                              "[${userInfo?.posturalProblems?.join(", ")}]",
                              style: valueTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Postural problems in family",
                              style: headlineTextStyle,
                            ),
                            Text(
                              userInfo.problemsInFamily? "yes": "no",
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Use of drugs that can interfere with balance",
                                style: headlineTextStyle,
                              )
                            ),
                            Text(
                              userInfo.useOfDrugs? "yes": "no",
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Trauma Info Card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Trauma".toUpperCase(),
                          style: titleTextStyle,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Other trauma",
                              style: headlineTextStyle,
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: Text(
                                "[${userInfo?.otherTrauma?.join(", ")}]",
                                style: valueTextStyle,
                                textAlign: TextAlign.end,
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Sight/Hear Defects Info Card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Difetti Visivi/Uditivi".toUpperCase(),
                          style: titleTextStyle,
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Difetti visivi",
                              style: headlineTextStyle,
                            ),
                            Text(
                              "${userInfo?.sightProblems?.join(", ")}",
                              style: valueTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Difetti uditivi",
                              style: headlineTextStyle,
                            ),
                            Text(
                              userInfo.hearingProblems.toString(),
                              style: valueTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 76),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Edit settings..."),
        child: Icon(Icons.edit),
      ),
    );
  }
}
