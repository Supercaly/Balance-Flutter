
import 'package:balance_app/bloc/events/intro_events.dart';
import 'package:balance_app/bloc/states/intro_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroBloc extends Bloc<IntroEvents, IntroState> {
  @override
  IntroState get initialState => IdleState();

  @override
  Stream<IntroState> mapEventToState(IntroEvents event) async* {
    // Check if the event is for validation
    if (event is NeedToValidateEvent)
      yield NeedToValidateState();
    // Check if the event is for validation result
    else if (event is ValidationResultEvent)
      yield ValidationResultState(event.isValid);
  }
}