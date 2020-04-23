
import 'package:balance_app/model/measurement.dart';

/// Base event of the result page
abstract class ResultEvents {
  const ResultEvents();
}

/// Event for fetch the result
class FetchResult extends ResultEvents {
  final int measurementId;
  const FetchResult(this.measurementId);
}

class ExportResult extends ResultEvents {
  final Measurement measurement;
  const ExportResult(this.measurement);
}