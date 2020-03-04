import 'package:moor_flutter/moor_flutter.dart';
part 'moor-database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get creationDate => dateTime().named("creation_date")();
  BoolColumn get eyesOpen => boolean().named("eyes_open").withDefault(Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@UseMoor(tables: [Tasks])
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

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() => select(tasks).watch();
  Future<int> insertTask(Task task) => into(tasks).insert(task);
}