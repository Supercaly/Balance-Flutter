
abstract class IntroState {
  const IntroState();
}

class IdleState extends IntroState {}
class NeedToValidateState extends IntroState {
  final int index;

  const NeedToValidateState(this.index);
}
class ValidationSuccessState extends IntroState {}