
/// Class representing a statokinesigram
///
/// This model class contains all the computed
/// features values for a statokinesigram: time
/// domain features, frequency domain features,
/// structural features and gyroscopic features.p
class Statokinesigram {
  final List<CogV> cogv;

  final double swayPath;
  final double meanDisplacement;
  final double stdDisplacement;
  final double minDist;
  final double maxDist;

  final double meanFrequencyAP;
  final double meanFrequencyML;
  final double frequencyPeakAP;
  final double frequencyPeakML;
  final double f80AP;
  final double f80ML;

  final double np;
  final double meanTime;
  final double stdTime;
  final double meanDistance;
  final double stdDistance;
  final double meanPeaks;
  final double stdPeaks;

  final double grX;
  final double grY;
  final double grZ;
  final double gmX;
  final double gmY;
  final double gmZ;
  final double gvX;
  final double gvY;
  final double gvZ;
  final double gkX;
  final double gkY;
  final double gkZ;
  final double gsX;
  final double gsY;
  final double gsZ;

  Statokinesigram({
    this.cogv, this.swayPath, this.meanDisplacement,
    this.stdDisplacement, this.minDist, this.maxDist, this.meanFrequencyAP, this.meanFrequencyML,
    this.frequencyPeakAP, this.frequencyPeakML, this.f80AP, this.f80ML, this.np, this.meanTime,
    this.stdTime, this.meanDistance, this.stdDistance, this.meanPeaks, this.stdPeaks, this.grX,
    this.grY, this.grZ, this.gmX, this.gmY, this.gmZ, this.gvX, this.gvY, this.gvZ, this.gkX,
    this.gkY, this.gkZ, this.gsX, this.gsY, this.gsZ
  });
}

class CogV {
  final double ap;
  final double ml;

  CogV(this.ap, this.ml);
}