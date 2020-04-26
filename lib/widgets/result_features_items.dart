
import 'package:balance_app/model/cogv_data.dart';
import 'package:flutter/material.dart';
import 'package:balance_app/model/statokinesigram.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Widget containing the all the features related
/// elements of [ResultScreen]
class ResultFeaturesItems extends StatelessWidget {
  final Statokinesigram statokinesigram;

  ResultFeaturesItems(this.statokinesigram);

  @override
  Widget build(BuildContext context) {
    // TextStyles for the Widget
    final titleTextStyle = Theme.of(context).textTheme.subtitle2.copyWith(
      fontSize: 17,
    );
    final headlineTextStyle = Theme.of(context).textTheme.bodyText1;
    final valueTextStyle = Theme.of(context).textTheme.caption;
    final valueBoldTextStyle = Theme.of(context).textTheme.caption.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: <Widget>[
        // Charts card
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Charts",
                  style: titleTextStyle,
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: charts.LineChart(
                    _createCOGvBallSeries(statokinesigram?.cogv),
                    animate: true,
                    behaviors: [
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.bottom
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: charts.LineChart(
                    _createCOGvSeries(statokinesigram?.cogv),
                    animate: true,
                    customSeriesRenderers: [
                      charts.LineRendererConfig(
                        customRendererId: "cogvChartArea",
                        includeArea: true,
                        stacked: true
                      )
                    ],
                    behaviors: [
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.bottom,
                      )
                    ],
                  ),
                )
              ]
            )
          ),
        ),
        // Time domain features card
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Time Domain Features",
                  style: titleTextStyle,
                ),
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sway Path", style: headlineTextStyle),
                        Text(
                          _formatFeature(statokinesigram?.swayPath, "mm/s"),
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mean Displacement", style: headlineTextStyle),
                        Text(
                          _formatFeature(statokinesigram?.meanDisplacement, "mm/s"),
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("STD Displacement", style: headlineTextStyle),
                        Text(
                          _formatFeature(statokinesigram?.stdDisplacement, "mm/s"),
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Range", style: headlineTextStyle),
                        Flexible(
                          child: Text(
                            statokinesigram?.minDist != null && statokinesigram?.maxDist != null
                              ? "[${statokinesigram.minDist.toStringAsFixed(4)} mm/s - ${statokinesigram.maxDist.toStringAsFixed(4)} mm/s]"
                              : "-",
                            style: valueTextStyle,
                            //textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ]
                )
              ],
            ),
          ),
        ),
        // Frequency domain features card
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Frequency Domain Features",
                  style: titleTextStyle,
                ),
                SizedBox(height: 16),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Mean Frequency", style: headlineTextStyle,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "AP: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.meanFrequencyAP, "Hz")),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.meanFrequencyML, "Hz")),
                                ]
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Frequency Peak", style: headlineTextStyle,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "AP: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.frequencyPeakAP, "Hz")),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.frequencyPeakML, "Hz")),
                                ]
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("F80", style: headlineTextStyle,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "AP: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.f80AP, "Hz")),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML: ", style: valueBoldTextStyle),
                                  TextSpan(text: _formatFeature(statokinesigram?.f80ML, "Hz")),
                                ]
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        // Structural features card
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Structural Features",
                  style: titleTextStyle,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("NP", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("MT", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("ST", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("MD", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("SD", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("MP", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("SP", style: headlineTextStyle,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          _formatFeature(statokinesigram?.np, ""),
                          style: valueTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.meanTime, " s"),
                          style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.stdTime, " s"),
                          style: valueTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.meanDistance, " mm"),
                          style: valueTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.stdDistance, " mm"),
                          style: valueTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.meanPeaks, " s"),
                          style: valueTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          _formatFeature(statokinesigram?.stdPeaks, " s"),
                          style: valueTextStyle,
                        ),
                      ],
                    )
                  ]
                ),
              ],
            ),
          ),
        ),
        // Gyroscopic features card
        Card(
          margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Gyroscopic Features",
                  style: titleTextStyle,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("GR", style: headlineTextStyle,),
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "X: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.grX, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.grY, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.grZ, "degrees/s")),
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("GM", style: headlineTextStyle,),
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "X: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gmX, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gmY, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gmZ, "degrees/s")),
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("GV", style: headlineTextStyle,),
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "X: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gvX, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gvY, "degrees/s")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gvZ, "degrees/s")),
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("GK", style: headlineTextStyle,),
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "X: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gkX, "")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gkY, "")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gkZ, "")),
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("GS", style: headlineTextStyle,),
                    Column(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "X: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gsX, "")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gsY, "")),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z: ", style: valueBoldTextStyle),
                              TextSpan(text: _formatFeature(statokinesigram?.gsZ, "")),
                            ]
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Creates the data for the COGv ball chart
  static List<charts.Series<CogvData, double>> _createCOGvBallSeries(List<CogvData> cogv) {
    return [
      charts.Series<CogvData, double>(
        id: "AP x ML",
        data: cogv?? [],
        domainFn: (CogvData datum, _) => datum.ap,
        measureFn: (CogvData datum, _) => datum.ml,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }

  /// Creates the data for the COGv chart
  static List<charts.Series<CogvData, double>> _createCOGvSeries(List<CogvData> cogv) {
    return [
      charts.Series<CogvData, double>(
        id: "AP",
        data: cogv?? [],
        domainFn: (datum, index) => index.toDouble(),
        measureFn: (datum, _) => datum.ap,
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      )..setAttribute(charts.rendererIdKey, "cogvChartArea"),
      charts.Series<CogvData, double>(
        id: "ML",
        data: cogv?? [],
        domainFn: (datum, index) => index.toDouble(),
        measureFn: (datum, _) => datum.ml,
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
      )..setAttribute(charts.rendererIdKey, "cogvChartArea"),
    ];
  }

  /// Static method to correctly format a feature [String]
  static String _formatFeature(double feature, String unit) {
    if (feature != null)
      if (!unit.isEmpty)
        return "${feature.toStringAsFixed(4)} $unit";
      else
        return "${feature.toStringAsFixed(4)}";
    else
      return "-";
  }
}