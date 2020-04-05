
/// Repository of the result screen
class ResultRepository {

  /// Computes the statokinesigram from a [measurementId]
  Future<int> getResult(int measurementId) async {
    if (measurementId == null)
      return Future.error(ArgumentError("measurementId is null"));
    // TODO: 02/04/20 Put real code here
    return Future.delayed(Duration(seconds: 2), () => 0);
  }
}