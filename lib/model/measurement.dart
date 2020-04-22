
import 'package:floor/floor.dart';

/// Represent one single measurement in the database
///
/// Every measurement in the measurements table is stored as a row,
/// this class represent a single row of that table.
@Entity(tableName: "measurements")
class Measurement {
  @PrimaryKey(autoGenerate: true)
  final int id;
  @ColumnInfo(name: "creation_date", nullable: false)
  final int creationDate;
  @ColumnInfo(name: "eyes_open", nullable: false)
  final bool eyesOpen;

  Measurement({this.id, this.creationDate, this.eyesOpen});

  /// Static method for creating an instance of [Measurement]
  /// with autoincrement [id], [creationDate] of now
  /// and given [eyesOpen] flag.
  static Measurement create({bool eyesOpen}) =>
    Measurement(
      creationDate: DateTime.now().millisecondsSinceEpoch,
      eyesOpen: eyesOpen
    );

  @override
  bool operator ==(other) => other is Measurement && 
    other.id == this.id && 
    other.creationDate == this.creationDate && 
    other.eyesOpen == this.eyesOpen;

  @override
  int get hashCode => id.hashCode^creationDate.hashCode^eyesOpen.hashCode;

  @override
  String toString() => "Measurement(id=$id, creationDate=$creationDate, eyesOpen=$eyesOpen)";
}