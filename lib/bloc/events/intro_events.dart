
abstract class IntroEvents {
  const IntroEvents();
}

class NeedToValidateEvent extends IntroEvents {
  final int index;

  const NeedToValidateEvent(this.index);
}
class ValidationSuccessEvent extends IntroEvents {}