import 'package:balance_app/model/measurement.dart';
import 'package:balance_app/moor/moor-database.dart';

/// Repository class for retrieving all the old measurements
///
/// This class implements a Repository in the Design Pattern Bloc
/// and has the purpose of returning all the [Measurement] objects
/// wherever they are needed
class MeasurementsRepository {
  final MoorDatabase database = MoorDatabase();

  /// Return all the old measurements
  Future<List<Task>> getMeasurements() {
    return database.getAllTasks();
    // TODO: 04/03/20 Convert this to a call to the database with real data
    return Future.value([
      Task(id: 1, creationDate: DateTime.now(), eyesOpen: true),
      Task(id: 2, creationDate: DateTime.now(), eyesOpen: false),
      Task(id: 3, creationDate: DateTime.now(), eyesOpen: false),
      Task(id: 4, creationDate: DateTime.now(), eyesOpen: true),
    ]);
  }
}