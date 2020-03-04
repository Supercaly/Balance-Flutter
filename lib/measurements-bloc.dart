
import 'package:balance_app/measurements-events.dart';
import 'package:balance_app/measurements-repository.dart';
import 'package:balance_app/measurements-state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeasurementsBloc extends Bloc<MeasurementsEvents, MeasurementsState> {
  final MeasurementsRepository repository = MeasurementsRepository();

  MeasurementsBloc._();

  factory MeasurementsBloc.create() => MeasurementsBloc._()..add(MeasurementsEvents.fetch);

  @override
  MeasurementsState get initialState => MeasurementsEmpty();

  @override
  Stream<MeasurementsState> mapEventToState(MeasurementsEvents event) async* {
    switch(event) {
      case MeasurementsEvents.fetch:
        yield MeasurementsLoading();
        try {
          yield MeasurementsSuccess(await repository.getMeasurements());
        } catch(_) {
          yield MeasurementsError();
        }
        break;
    }
  }
}