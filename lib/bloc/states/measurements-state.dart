import 'package:balance_app/model/measurement.dart';

/// Base State of the measurements page
abstract class MeasurementsState {
  const MeasurementsState();
}

/// State for when there is no data
class MeasurementsEmpty extends MeasurementsState {}

/// State for when the loading
class MeasurementsLoading extends MeasurementsState {}

/// State for when the data is retrieved successfully
class MeasurementsSuccess extends MeasurementsState {
  final List<Measurement> measurements;
  const MeasurementsSuccess(this.measurements);
}

/// State for when there is an error
class MeasurementsError extends MeasurementsState {
  final Error error;
  const MeasurementsError(this.error);
}