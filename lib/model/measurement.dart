import 'package:floor/floor.dart';

@Entity(tableName: "measurements")
class Measurement {
  @PrimaryKey(autoGenerate: true)
  final int id;
  @ColumnInfo(name: "creation_date", nullable: false)
  final int creationDate;
  @ColumnInfo(name: "eyes_open", nullable: false)
  final bool eyesOpen;

  Measurement({this.id, this.creationDate, this.eyesOpen});
}