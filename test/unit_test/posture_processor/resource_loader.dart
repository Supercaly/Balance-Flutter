
import 'dart:io';

import 'package:balance_app/posture_processor/src/math/matrix.dart';

/// Load a [Matrix] from the [test_resources] directory
Matrix loadMatrixFromResource(String fileName) {
  File file = Directory.current.path.endsWith("test")
    ? File("test_resources/cogv/"+fileName)
    : File("test/test_resources/cogv/"+fileName);

  final List<double> result = [];
  final testDataLines = file.readAsLinesSync();
  if (testDataLines == null || testDataLines.isEmpty)
    return null;

  final colNum = testDataLines[0].split(" ").length;
  for(var line in testDataLines) {
    if (line.isEmpty)
      continue;
    final splitted = line.split(" ");
    for (var i = 0; i < colNum; i++) {
      result.add(double.parse(splitted[i]));
    }
  }
  return Matrix(testDataLines.length, colNum, result);
}

void writeMatrixToFile(Matrix matrix, String fileName) async{
  File file = Directory.current.path.endsWith("test")
    ? File("test_results/cogv/"+fileName)
    : File("test/test_results/cogv/"+fileName);
  await file.create(recursive: true);

  final rows = matrix.extractRows();
  String dataString = '';
  for(var row in rows) {
    dataString += "${row.join(" ")}\n";
  }
  file.writeAsString(dataString.toString());
}