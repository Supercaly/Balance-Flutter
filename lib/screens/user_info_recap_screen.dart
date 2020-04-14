
import 'package:flutter/material.dart';
import 'package:balance_app/bloc/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Extension function used in [UserInfoRecapScreen].
extension _UserInfoIterableExtension on Iterable<bool> {
  /// Generate an [Iterable] of [int] where the elements
  /// are the index of all the elements with value true.
  Iterable<int> whereIndexed() sync*{
    for (var i = 0; i < this.length; i++)
       if (this.elementAt(i))
        yield i;
  }
}

class UserInfoRecapScreen extends StatelessWidget {
  /// Get the String of gender
  static String _getGenderString(int gender) {
    if (gender == null)
      return "Unknown";

    switch(gender) {
      case 1:
        return "Male";
      case 2:
        return "Female";
      default:
        return "Unknown";
    }
  }
  /// Get the String of posture problems
  static String _getPostureString(List<bool> list) {
    if (list == null)
      return "none";

    final problems = ["Scogliosi", "Cifosi", "Lordosi"];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of other trauma
  static String _getTraumaString(List<bool> list) {
    if (list == null)
      return "none";

    final problems = ["Fratture", "Operazioni agli arti", "Cadute", "Distorsioni", "Trauma cranici"];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of sight problems
  static String _getSightString(List<bool> list) {
    if (list == null)
      return "none";

    final problems = ["Miopia", "Presbiopia", "Ipermetropia"];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of hearing problems
  static String _getHearingString(int value) {
    if (value == null || value < 0 || value > 5)
      return "none";

    final problems = ["none", "leggera", "moderata", "severa", "profonda"];
    return problems[value];
  }

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
            // Show the loading screen
            if (state is UserInfoLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            // Show the user info cards
            final userInfo = (state as UserInfoSuccess).value;
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
                              userInfo?.age?.toString() ?? "-",
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
                              _getGenderString(userInfo?.gender),
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
                              userInfo?.height != null? "${userInfo.height.toStringAsFixed(1)} cm": "-",
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
                              userInfo?.weight != null? "${userInfo.weight.toStringAsFixed(1)} Kg": "-",
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
                              _getPostureString(userInfo?.posturalProblems),
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
                                userInfo != null && userInfo.problemsInFamily? "yes": "no",
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
                              userInfo != null && userInfo.useOfDrugs? "yes": "no",
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
                                _getTraumaString(userInfo?.otherTrauma),
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
                              _getSightString(userInfo?.sightProblems),
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
                              _getHearingString(userInfo.hearingProblems),
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
