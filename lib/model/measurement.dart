
import 'package:floor/floor.dart';

/// Represent one single measurement in the database
@Entity(tableName: "measurements")
class Measurement {
  @PrimaryKey(autoGenerate: true)
  final int id;

  // General info about the measurement
  @ColumnInfo(name: "creation_date", nullable: false)
  final int creationDate;
  @ColumnInfo(name: "eyes_open", nullable: false)
  final bool eyesOpen;

  // Computed features
  @ColumnInfo(name: "sway_path")
  final double swayPath;
  @ColumnInfo(name: "mean_displacement")
  final double meanDisplacement;
  @ColumnInfo(name: "std_displacement")
  final double stdDisplacement;
  @ColumnInfo(name: "range_min")
  final double minDist;
  @ColumnInfo(name: "range_max")
  final double maxDist;

  @ColumnInfo(name: "mean_frequency_ap")
  final double meanFrequencyAP;
  @ColumnInfo(name: "mean_frequency_ml")
  final double meanFrequencyML;
  @ColumnInfo(name: "frequency_peak_ap")
  final double frequencyPeakAP;
  @ColumnInfo(name: "frequency_peak_ml")
  final double frequencyPeakML;
  @ColumnInfo(name: "f80_ap")
  final double f80AP;
  @ColumnInfo(name: "f80_ml")
  final double f80ML;

  @ColumnInfo()
  final double np;
  @ColumnInfo(name: "mean_time")
  final double meanTime;
  @ColumnInfo(name: "std_time")
  final double stdTime;
  @ColumnInfo(name: "mean_distance")
  final double meanDistance;
  @ColumnInfo(name: "std_distance")
  final double stdDistance;
  @ColumnInfo(name: "mean_peaks")
  final double meanPeaks;
  @ColumnInfo(name: "std_peaks")
  final double stdPeaks;

  @ColumnInfo() final double grX;
  @ColumnInfo() final double grY;
  @ColumnInfo() final double grZ;
  @ColumnInfo() final double gmX;
  @ColumnInfo() final double gmY;
  @ColumnInfo() final double gmZ;
  @ColumnInfo() final double gvX;
  @ColumnInfo() final double gvY;
  @ColumnInfo() final double gvZ;
  @ColumnInfo() final double gkX;
  @ColumnInfo() final double gkY;
  @ColumnInfo() final double gkZ;
  @ColumnInfo() final double gsX;
  @ColumnInfo() final double gsY;
  @ColumnInfo() final double gsZ;

  Measurement({
    this.id,
    this.creationDate,
    this.eyesOpen,
    this.swayPath, this.meanDisplacement, this.stdDisplacement, this.minDist, this.maxDist,
    this.frequencyPeakAP, this.frequencyPeakML, this.meanFrequencyML, this.meanFrequencyAP,
    this.f80ML, this.f80AP, this.np, this.meanTime, this.stdTime, this.meanDistance, this.stdDistance,
    this.meanPeaks, this.stdPeaks, this.gsX, this.gsY, this.gsZ, this.gkX, this.gkY, this.gkZ,
    this.gmX, this.gmY, this.gmZ, this.gvX, this.gvY, this.gvZ, this.grX, this.grY, this.grZ
  });

  /// Creates a simple instance of [Measurement].
  ///
  /// This factory method return a new instance
  /// of [Measurement] with only [creationDate],
  /// [eyesOpen] and auto-incremented [id].
  /// The other parameters will be set to null.
  factory Measurement.simple({
    int creationDate,
    bool eyesOpen,
  }) => Measurement(creationDate: creationDate, eyesOpen: eyesOpen);

  /// Returns true if all the features are non-null
  bool get hasFeatures => this.swayPath != null && this.meanDisplacement != null &&
    this.stdDisplacement != null && this.minDist != null && this.maxDist != null &&
    this.frequencyPeakAP != null && this.frequencyPeakML != null && this.meanFrequencyML != null &&
    this.meanFrequencyAP != null && this.f80ML != null && this.f80AP != null && this.np != null &&
    this.meanTime != null && this.stdTime != null && this.meanDistance != null &&
    this.stdDistance != null && this.meanPeaks != null && this.stdPeaks != null &&
    this.gsX != null && this.gsY != null && this.gsZ != null && this.gkX != null &&
    this.gkY != null && this.gkZ != null && this.gmX != null && this.gmY != null &&
    this.gmZ != null && this.gvX != null && this.gvY != null && this.gvZ != null &&
    this.grX != null && this.grY != null && this.grZ != null;

  @override
  bool operator ==(other) => other is Measurement &&
    this.id == other.id &&
    this.creationDate == other.creationDate &&
    this.eyesOpen == other.eyesOpen &&
    this.swayPath == other.swayPath && this.meanDisplacement == other.meanDisplacement &&
    this.stdDisplacement == other.stdDisplacement && this.minDist == other.minDist &&
    this.maxDist == other.maxDist && this.frequencyPeakAP == other.frequencyPeakAP &&
    this.frequencyPeakML == other.frequencyPeakML && this.meanFrequencyML == other.meanFrequencyML &&
    this.meanFrequencyAP == other.meanFrequencyAP && this.f80ML == other.f80ML &&
    this.f80AP == other.f80AP && this.np == other.np && this.meanTime == other.meanTime &&
    this.stdTime == other.stdTime && this.meanDistance == other.meanDistance &&
    this.stdDistance == other.stdDistance && this.meanPeaks == other.meanPeaks &&
    this.stdPeaks == other.stdPeaks && this.gsX == other.gsX && this.gsY == other.gsY &&
    this.gsZ == other.gsZ && this.gkX == other.gkX && this.gkY == other.gkY &&
    this.gkZ == other.gkZ && this.gmX == other.gmX && this.gmY == other.gmY &&
    this.gmZ == other.gmZ && this.gvX == other.gvX && this.gvY == other.gvY &&
    this.gvZ == other.gvZ && this.grX == other.grX && this.grY == other.grY &&
    this.grZ == other.grZ;

  @override
  int get hashCode => id.hashCode^creationDate.hashCode^eyesOpen.hashCode^
    swayPath.hashCode^meanDisplacement.hashCode^stdDisplacement.hashCode^
    minDist.hashCode^maxDist.hashCode^frequencyPeakAP.hashCode^
    frequencyPeakML.hashCode^meanFrequencyML.hashCode^meanFrequencyAP.hashCode^
    f80ML.hashCode^f80AP.hashCode^np.hashCode^meanTime.hashCode^stdTime.hashCode^
    meanDistance.hashCode^stdDistance.hashCode^meanPeaks.hashCode^stdPeaks.hashCode^
    gsX.hashCode^gsY.hashCode^gsZ.hashCode^gkX.hashCode^gkY.hashCode^gkZ.hashCode^
    gmX.hashCode^gmY.hashCode^gmZ.hashCode^gvX.hashCode^gvY.hashCode^gvZ.hashCode^
    grX.hashCode^grY.hashCode^grZ.hashCode;

  @override
  String toString() => "Measurement("
    "id=$id, "
    "creationDate=$creationDate, "
    "eyesOpen=$eyesOpen, "
    "swayPath=$swayPath, "
    "meanDisplacement=$meanDisplacement, "
    "stdDisplacement=$stdDisplacement, "
    "minDist=$minDist, "
    "maxDist=$maxDist, "
    "frequencyPeakAP=$frequencyPeakAP, "
    "frequencyPeakML=$frequencyPeakML, "
    "meanFrequencyML=$meanFrequencyML, "
    "meanFrequencyAP=$meanFrequencyAP, "
    "f80ML=$f80ML, "
    "f80AP=$f80AP, "
    "np=$np, "
    "meanTime=$meanTime, "
    "stdTime=$stdTime, "
    "meanDistance=$meanDistance, "
    "stdDistance=$stdDistance, "
    "meanPeaks=$meanPeaks, "
    "stdPeaks=$stdPeaks, "
    "gsX=$gsX, "
    "gsY=$gsY, "
    "gsZ=$gsZ, "
    "gkX=$gkX, "
    "gkY=$gkY, "
    "gkZ=$gkZ, "
    "gmX=$gmX, "
    "gmY=$gmY, "
    "gmZ=$gmZ, "
    "gvX=$gvX, "
    "gvY=$gvY, "
    "gvZ=$gvZ, "
    "grX=$grX, "
    "grY=$grY, "
    "grZ=$grZ"
    ")";
}