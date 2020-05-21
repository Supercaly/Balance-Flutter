
import 'package:balance_app/manager/preference_manager.dart';
import 'package:balance_app/model/user_info.dart';
import 'package:balance_app/res/string.dart';
import 'package:balance_app/routes.dart';
import 'package:flutter/material.dart';

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
      return BStrings.unknown_txt;

    switch(gender) {
      case 1:
        return BStrings.male_txt;
      case 2:
        return BStrings.female_txt;
      default:
        return BStrings.unknown_txt;
    }
  }
  /// Get the String of posture problems
  static String _getPostureString(List<bool> list) {
    if (list == null || list.where((element) => element).isEmpty)
      return BStrings.none;

    final problems = [BStrings.scoliosis_txt, BStrings.kyphosis_txt, BStrings.lordosis_txt];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of other trauma
  static String _getTraumaString(List<bool> list) {
    if (list == null || list.where((element) => element).isEmpty)
      return BStrings.none;

    final problems = [BStrings.fractures_txt, BStrings.limb_operations_txt, BStrings.falls_txt, BStrings.distortions_txt, BStrings.head_trauma];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of sight problems
  static String _getSightString(List<bool> list) {
    if (list == null || list.where((element) => element).isEmpty)
      return BStrings.none;

    final problems = [BStrings.myopia_txt, BStrings.presbyopia_txt, BStrings.farsightedness_txt];
    return "[${list.whereIndexed().map((e) => problems[e]).join(", ")}]";
  }
  /// Get the String of hearing problems
  static String _getHearingString(int value) {
    if (value == null || value < 0 || value > 5)
      return BStrings.none;

    final problems = [BStrings.none, BStrings.light_txt, BStrings.moderate_txt, BStrings.severe_txt, BStrings.deep_txt];
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
        title: Text(BStrings.your_personal_info_txt),
      ),
      body: FutureBuilder(
        future: PreferenceManager.userInfo,
        builder: (context, snapshot) {
          // Show loading screen
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          final userInfo = snapshot.data as UserInfo;
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
                        BStrings.general_title,
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.age_txt,
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
                            BStrings.gender_txt,
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
                            BStrings.height_txt,
                            style: headlineTextStyle,
                          ),
                          Text(
                            userInfo?.height != null
                              ? "${userInfo.height.toStringAsFixed(1)} cm"
                              : "-",
                            style: valueTextStyle,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.weight_txt,
                            style: headlineTextStyle,
                          ),
                          Text(
                            userInfo?.weight != null
                              ? "${userInfo.weight.toStringAsFixed(1)} Kg"
                              : "-",
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
                        BStrings.health_title,
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.postural_problems_txt,
                            style: headlineTextStyle,
                          ),
                          Flexible(
                            child: Text(
                              _getPostureString(userInfo?.posturalProblems),
                              style: valueTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.postural_problems_in_family_txt,
                            style: headlineTextStyle,
                          ),
                          Text(
                            userInfo != null && userInfo.problemsInFamily ? BStrings.yes : BStrings.no,
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
                              BStrings.use_of_drugs_txt,
                              style: headlineTextStyle,
                            )
                          ),
                          Text(
                            userInfo != null && userInfo.useOfDrugs ? BStrings.yes : BStrings.no,
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
                        BStrings.trauma_title,
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            BStrings.other_trauma_txt,
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
                        BStrings.hearing_defects_title,
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.sight_defects_txt,
                            style: headlineTextStyle,
                          ),
                          Flexible(
                            child: Text(
                              _getSightString(userInfo?.sightProblems),
                              style: valueTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            BStrings.hearing_defects_txt,
                            style: headlineTextStyle,
                          ),
                          Text(
                            _getHearingString(userInfo?.hearingProblems),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Open the onboarding route with UserInfo from memory
          Navigator.pushNamed(
            context,
            Routes.onboarding,
            arguments: await PreferenceManager.userInfo
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
