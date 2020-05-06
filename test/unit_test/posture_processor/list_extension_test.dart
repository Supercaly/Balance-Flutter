
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:balance_app/posture_processor/src/list_extension.dart';

void main() {
  test("average computed correctly", () {
    final intList = [1, 2, 3, 4, 5, 6];
    expect(intList.average(), equals(3.5));

    final doubleList = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];
    expect(doubleList.average(), equals(3.5));

    final rnd = Random();
    final randomList = List.generate(20, (index) => rnd.nextDouble());
    double avg = 0;
    double sum = 0;
    for (var i in randomList) {
      sum += i;
    }
    avg = sum / randomList.length;
    expect(randomList.average(), equals(avg));
  });

  test("average of empty list return NaN", () {
    List<int> list = [];
    expect(list.average(), isNaN);
  });

  test("standard deviation computed correctly", () {
    final intList = [1, 2, 3, 4, 5, 6];
    expect(intList.std(), within(distance: 0.000000000001, from: 1.870828693387));

    final doubleList = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0];
    expect(doubleList.std(), within(distance: 0.000000000001, from: 1.870828693387));

    final rnd = Random();
    final randomList = List.generate(20, (index) => rnd.nextDouble());
    double avg = randomList.average();
    double sum = 0;
    for (var i in randomList) {
      sum += pow(i - avg, 2);
    }
    final std = sqrt(sum / (randomList.length - 1));
    expect(randomList.std(), equals(std));
  });

  test("std of empty list return NaN", () {
    List<int> list = [];
    expect(list.std(), isNaN);
  });

  test("std of one-element list return 0", () {
    List<int> list = [12];
    expect(list.std(), equals(0.0));
  });
}