
abstract class IntroEvents {
  const IntroEvents();
}

class NeedToValidateEvent extends IntroEvents {}
class ValidationResultEvent extends IntroEvents {
  final bool isValid;

  const ValidationResultEvent(this.isValid);
}