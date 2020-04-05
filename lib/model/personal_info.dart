
/// Class that store users'personal information
class PersonalInfo {
  final int height;
  final int weight;
  final int age;
  /// Can be [0,1,2] -> [unknown, male, female]
  final int gender;
  final List<int> posturalProblems;
  final bool problemsInFamily;
  final bool useOfDrugs;
  final List<int> otherTrauma;
  final List<int> sightProblems;
  final int hearingProblems;

  PersonalInfo({
    this.height,
    this.weight,
    this.age,
    this.gender,
    this.posturalProblems,
    this.problemsInFamily,
    this.useOfDrugs,
    this.otherTrauma,
    this.sightProblems,
    this.hearingProblems,
  });
}