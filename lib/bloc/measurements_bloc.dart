import 'package:balance_app/bloc/states/measurements_state.dart';
import 'package:balance_app/floor/measurement_database.dart';
import 'package:balance_app/repository/measurements_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events/measurements_events.dart';

/// Class representing the Bloc for Measurements page
///
/// This class is the core of the Bloc pattern, it converts from [MeasurementsEvents]
/// to [MeasurementsState]
class MeasurementsBloc extends Bloc<MeasurementsEvents, MeasurementsState> {
  final MeasurementsRepository repository;

  MeasurementsBloc._(MeasurementDatabase db): repository = MeasurementsRepository(db);
  factory MeasurementsBloc.create(MeasurementDatabase db) => MeasurementsBloc._(db)..add(MeasurementsEvents.fetch);

  @override
  MeasurementsState get initialState => MeasurementsLoading();

  @override
  Stream<MeasurementsState> mapEventToState(MeasurementsEvents event) async* {
    switch(event) {
      // fetch the data from the repository
      case MeasurementsEvents.fetch:
        try {
          final measurements = await repository.getMeasurements();
          if (measurements.isEmpty)
            yield MeasurementsEmpty();
          else
            yield MeasurementsSuccess(measurements);
        } catch(e) {
          yield MeasurementsError(e);
        }
        break;
    }
  }
}