
/// Base event of the result page
abstract class ResultEvents {
  const ResultEvents();
}

/// Event for fetch the result
class FetchResult extends ResultEvents {
  final int measurementId;
  const FetchResult(this.measurementId);
}