import 'package:balance_app/dao/measurement-dao.dart';
import 'package:balance_app/model/measurement.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor-database.g.dart';

@UseMoor(tables: [Measurements], daos: [MeasurementDao])
class MoorDatabase extends _$MoorDatabase {
  static MoorDatabase _instance;

  factory MoorDatabase() {
    if (_instance == null)
      _instance = MoorDatabase._();
    return _instance;
  }

  MoorDatabase._(): super(FlutterQueryExecutor.inDatabaseFolder(path: "db.sqlite", logStatements: true));

  @override
  int get schemaVersion => 1;
}