
import 'package:balance_app/model/raw_measurement_data.dart';
import 'package:balance_app/posture_processor/src/gyroscopic_features.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/resource_loader.dart';

void main() {
  List<RawMeasurementData> rawData;

  setUpAll(() {
    final initialData = loadMatrixFromResource("gyro/test_data.txt");
    rawData = List.generate(initialData.rows, (i) =>
      RawMeasurementData(
        gyroscopeX: initialData.get(i, 0),
        gyroscopeY: initialData.get(i, 1),
        gyroscopeZ: initialData.get(i, 2),
      )
    );
  });

  test("compute gyroscopic features from data", () async{
    final res = await gyroscopicFeatures(rawData);

    // Check the range
    expect(res["grX"], within(distance: 0.00001, from: 0.10996));
    expect(res["grY"], within(distance: 0.00001, from: 0.15272));
    expect(res["grZ"], within(distance: 0.00001, from: 0.10263));

    // Check the max
    expect(res["gmX"], within(distance: 0.000001, from: 0.077695));
    expect(res["gmY"], within(distance: 0.000001, from: 0.061033));
    expect(res["gmZ"], within(distance: 0.000001, from: 0.046029));

    // Check the variance
    expect(res["gvX"], within(distance: 0.000000001, from: 0.000089872));
    expect(res["gvY"], within(distance: 0.00000001, from: 0.00021093));
    expect(res["gvZ"], within(distance: 0.000000001, from: 0.000040878));

    // Check the skewness
    //expect(res["gsX"], within(distance: null, from: null));
    //expect(res["gsY"], within(distance: null, from: null));
    //expect(res["gsZ"], within(distance: null, from: null));

    // Check the kurtosis
    //expect(res["gkX"], within(distance: null, from: null));
    //expect(res["gkY"], within(distance: null, from: null));
    //expect(res["gkZ"], within(distance: null, from: null));
  });
}