
abstract class CountdownState {
  const CountdownState();
}

class CountdownIdleState extends CountdownState {}
class CountdownPreMeasureState extends CountdownState {}
class CountdownMeasureState extends CountdownState {}

class CountdownCompleteState extends CountdownState {
  final int result;
  final Exception error;

  const CountdownCompleteState._(this.result, this.error);
  factory CountdownCompleteState.success(int result) => CountdownCompleteState._(result, null);
  factory CountdownCompleteState.error(Exception ex) => CountdownCompleteState._(null, ex);

  @override
  String toString() => "CountdownCompleteState("
    "result=$result, "
    "error=$error"
    ")";
}
