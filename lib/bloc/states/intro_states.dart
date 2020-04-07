
abstract class IntroState {
  const IntroState();
}

class IdleState extends IntroState {}
class NeedToValidateState extends IntroState {
  final int index;

  const NeedToValidateState(this.index);
}
class ValidationResultState extends IntroState {
  final bool isValid;

  const ValidationResultState(this.isValid);
}