
abstract class IntroState {
  const IntroState();
}

class IdleState extends IntroState {}
class NeedToValidateState extends IntroState {}
class ValidationResultState extends IntroState {
  final bool isValid;

  const ValidationResultState(this.isValid);
}