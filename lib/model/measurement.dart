import 'package:moor_flutter/moor_flutter.dart';

class Measurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get creationDate => dateTime().named("creation_date")();
  BoolColumn get eyesOpen => boolean().named("eyes_open").withDefault(Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}