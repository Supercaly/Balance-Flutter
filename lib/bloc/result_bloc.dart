
import 'package:balance_app/bloc/events/result_events.dart';
import 'package:balance_app/bloc/states/result_states.dart';
import 'package:balance_app/repository/result_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Class representing the Bloc for Result screen
///
/// This class is the core of the bloc pattern, it converts form
/// [ResultEvents] to [ResultState]s
class ResultBloc extends Bloc<ResultEvents, ResultState> {
  final ResultRepository repository = ResultRepository();

  ResultBloc._();
  factory ResultBloc.create(int resultId) => ResultBloc._()..add(FetchResult(resultId));

  @override
  ResultState get initialState => ResultLoading();

  @override
  Stream<ResultState> mapEventToState(ResultEvents event) async* {
    if (event is FetchResult) {
      // fetch the data from the repository
      try {
        await repository.getResult(event.measurementId);
        print("Hola");
        yield ResultSuccess();
      } catch (e) {
        print("error");
        yield ResultError(e);
      }
    }
  }
}