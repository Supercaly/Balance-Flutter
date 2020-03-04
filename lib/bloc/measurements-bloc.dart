import 'package:balance_app/bloc/events/measurements-events.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/repository/measurements-repository.dart';
import 'package:balance_app/bloc/states/measurements-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class representing the Bloc for Measurements page
///
/// This class is the core of the Bloc pattern, it converts from [MeasurementsEvents]
/// to [MeasurementsState]
class MeasurementsBloc extends Bloc<MeasurementsEvents, MeasurementsState> {
  final MeasurementsRepository repository = MeasurementsRepository();

  MeasurementsBloc._();
  factory MeasurementsBloc.create() => MeasurementsBloc._()..add(MeasurementsEvents.fetch);

  @override
  MeasurementsState get initialState => MeasurementsLoading();

  @override
  Stream<MeasurementsState> mapEventToState(MeasurementsEvents event) async* {
    switch(event) {
      // fetch the data from the repository
      case MeasurementsEvents.fetch:
        yield MeasurementsLoading();
        try {
          final measurements = await repository.getMeasurements();
          if (measurements.isEmpty)
            yield MeasurementsEmpty();
          else
            yield MeasurementsSuccess(measurements.map((e) => Measurement(e.id, e.creationDate.toString(), e.eyesOpen)).toList());
        } catch(e) {
          yield MeasurementsError(e);
        }
        break;
    }
  }
}