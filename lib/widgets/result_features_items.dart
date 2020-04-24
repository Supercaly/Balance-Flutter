
import 'package:balance_app/model/statokinesigram.dart';
import 'package:flutter/material.dart';

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
                Placeholder(
                  fallbackHeight: 200,
                ),
                SizedBox(height: 8),
                Placeholder(
                  fallbackHeight: 200,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Sway Path", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("Mean Displacement", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("STD Displacement", style: headlineTextStyle,),
                        SizedBox(height: 8),
                        Text("Range", style: headlineTextStyle,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("0.0 mm/s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 mm/s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 mm/s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("[0.0 mm/s - 0.0 mm/s]", style: valueTextStyle,),
                      ],
                    )
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
                                  TextSpan(text: "AP:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
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
                                  TextSpan(text: "AP:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
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
                                  TextSpan(text: "AP:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: valueTextStyle,
                                children: [
                                  TextSpan(text: "ML:", style: valueBoldTextStyle),
                                  TextSpan(text: " 0.0 Hz"),
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
                        Text("0.0", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 mm", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 mm", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 s", style: valueTextStyle,),
                        SizedBox(height: 8),
                        Text("0.0 s", style: valueTextStyle,),
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
                              TextSpan(text: "X:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
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
                              TextSpan(text: "X:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
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
                              TextSpan(text: "X:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0 degrees/s"),
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
                              TextSpan(text: "X:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
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
                              TextSpan(text: "X:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Y:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
                            ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: valueTextStyle,
                            children: [
                              TextSpan(text: "Z:", style: valueBoldTextStyle),
                              TextSpan(text: " 0.0"),
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
}