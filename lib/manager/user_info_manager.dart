
import 'package:balance_app/model/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoManager {
  static const _height = "userHeight";
  static const _age = "userAge";
  static const _weight = "userWeight";
  static const _gender = "userGender";
  static const _posturalProblems = "posturalProblems";
  static const _problemsInFamily = "problemsInFamily";
  static const _useOfDrugs = "useOfDrugs";
  static const _otherTrauma = "otherTrauma";
  static const _sightProblems = "sightProblems";
  static const _hearingProblems = "hearingProblems";

  /// Return the stored [UserInfo]
  ///
  /// This method parse the anamnesis data stored
  /// in the [SharedPreferences] and return them
  /// as an instance of [UserInfo].
  /// If the stored height is null the entire object
  /// will be null.
  static Future<UserInfo> get userInfo async {
    var pref = await SharedPreferences.getInstance();
    var height = pref.getDouble(_height);
    if (height == null) return null;
    return UserInfo(
      height: height,
      age: pref.getInt(_age),
      weight: pref.getDouble(_weight),
      gender: pref.getInt(_gender),
      posturalProblems: pref.getString(_posturalProblems).split(",").map((e) => e == 'true').toList(),
      problemsInFamily: pref.getBool(_problemsInFamily),
      useOfDrugs: pref.getBool(_useOfDrugs),
      otherTrauma: pref.getString(_otherTrauma).split(",").map((e) => e == 'true').toList(),
      sightProblems: pref.getString(_sightProblems).split(",").map((e) => e == 'true').toList(),
      hearingProblems: pref.getInt(_hearingProblems),
    );
  }

  /// Update the stored [UserInfo]
  ///
  /// This method updates the anamnesis data
  /// stored in the [SharedPreferences] with
  /// the given values.
  /// Only the non-null given values will be
  /// updated so this method can be with optional
  /// parameters.
  static Future<void> update({
    double height,
    double weight,
    int age,
    int gender,
    List<bool> posturalProblems,
    bool problemsInFamily,
    bool useOfDrugs,
    List<bool> otherTrauma,
    List<bool> sightProblems,
    int hearingProblems,
  }) async {
    var pref = await SharedPreferences.getInstance();

    // Update the value of all the non-null given elements
    if (height != null)
      pref.setDouble(_height, height);
    if (age != null)
      pref.setInt(_age, age);
    if (weight != null)
      pref.setDouble(_weight, weight);
    if (gender != null)
      pref.setInt(_gender, gender);
    if (posturalProblems != null)
      pref.setString(_posturalProblems, posturalProblems.join(","));
    if (problemsInFamily != null)
      pref.setBool(_problemsInFamily, problemsInFamily);
    if (useOfDrugs != null)
      pref.setBool(_useOfDrugs, useOfDrugs);
    if (otherTrauma != null)
      pref.setString(_otherTrauma, otherTrauma.join(","));
    if (sightProblems != null)
      pref.setString(_sightProblems, sightProblems.join(","));
    if (hearingProblems != null)
      pref.setInt(_hearingProblems, hearingProblems);
  }
}