
import 'package:balance_app/model/measurement.dart';

abstract class MeasurementsState {
  const MeasurementsState();
}

class MeasurementsEmpty extends MeasurementsState {}
class MeasurementsLoading extends MeasurementsState {}
class MeasurementsSuccess extends MeasurementsState {
  final List<Measurement> measurements;

  const MeasurementsSuccess(this.measurements);
}
class MeasurementsError extends MeasurementsState {}