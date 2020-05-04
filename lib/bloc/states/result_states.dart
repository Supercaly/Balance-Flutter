
import 'package:balance_app/model/measurement.dart';

/// Base State of the result page
abstract class ResultState {
  const ResultState();
}

/// State for when the data is loading
class ResultLoading extends ResultState {}

/// State for when the data is retrieved successfully
class ResultSuccess extends ResultState {
  final Measurement measurement;

  const ResultSuccess(this.measurement);
}

/// State for when there is an error
class ResultError extends ResultState {
  final Error error;
  const ResultError(this.error);
}

/// State for when the export is completed successfully
class ResultExportSuccess extends ResultState {}