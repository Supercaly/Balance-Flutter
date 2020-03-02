import 'package:balance_app/text_appearance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the resultId from the arguments
    final int resultId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Result $resultId")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            // Result info card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.today, color: Theme.of(context).iconTheme.color),
                        SizedBox(width: 16),
                        Text(
                          "20/20/2020 20:20:20",
                          style: Theme.of(context).textTheme.cardBody,
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.remove_red_eye, color: Theme.of(context).iconTheme.color),
                        SizedBox(width: 16),
                        Text(
                          "Eyes open",
                          style: Theme.of(context).textTheme.cardBody,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Charts card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Charts",
                      style: Theme.of(context).textTheme.featureTitle,
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
            SizedBox(height: 16),
            // Time domain features card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Time Domain Features",
                      style: Theme.of(context).textTheme.featureTitle,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Sway Path", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("Mean Displacement", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("STD Displacement", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("Range", style: Theme.of(context).textTheme.featuresHeadline,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("0.0 mm/s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 mm/s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 mm/s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("[0.0 mm/s - 0.0 mm/s]", style: Theme.of(context).textTheme.featuresValue,),
                          ],
                        )
                      ]
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Frequency domain features card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Frequency Domain Features",
                      style: Theme.of(context).textTheme.featureTitle,
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Mean Frequency", style: Theme.of(context).textTheme.featuresHeadline,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "AP:", style: Theme.of(context).textTheme.featuresValueBold),
                                      TextSpan(text: " 0.0 Hz"),
                                    ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "ML:", style: Theme.of(context).textTheme.featuresValueBold),
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
                            Text("Frequency Peack", style: Theme.of(context).textTheme.featuresHeadline,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "AP:", style: Theme.of(context).textTheme.featuresValueBold),
                                      TextSpan(text: " 0.0 Hz"),
                                    ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "ML:", style: Theme.of(context).textTheme.featuresValueBold),
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
                            Text("F80", style: Theme.of(context).textTheme.featuresHeadline,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "AP:", style: Theme.of(context).textTheme.featuresValueBold),
                                      TextSpan(text: " 0.0 Hz"),
                                    ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.featuresValue,
                                    children: [
                                      TextSpan(text: "ML:", style: Theme.of(context).textTheme.featuresValueBold),
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
            SizedBox(height: 16),
            // Structural features card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Structural Features",
                      style: Theme.of(context).textTheme.featureTitle,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("NP", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("MT", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("ST", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("MD", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("SD", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("MP", style: Theme.of(context).textTheme.featuresHeadline,),
                            SizedBox(height: 8),
                            Text("SP", style: Theme.of(context).textTheme.featuresHeadline,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("0.0", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 mm", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 mm", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 s", style: Theme.of(context).textTheme.featuresValue,),
                            SizedBox(height: 8),
                            Text("0.0 s", style: Theme.of(context).textTheme.featuresValue,),
                          ],
                        )
                      ]
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Gyroscopic features card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Gyroscopic Features",
                      style: Theme.of(context).textTheme.featureTitle,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("GR", style: Theme.of(context).textTheme.featuresHeadline,),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "X:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Y:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Z:", style: Theme.of(context).textTheme.featuresValueBold),
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
                        Text("GM", style: Theme.of(context).textTheme.featuresHeadline,),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "X:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Y:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Z:", style: Theme.of(context).textTheme.featuresValueBold),
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
                        Text("GV", style: Theme.of(context).textTheme.featuresHeadline,),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "X:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Y:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0 degrees/s"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Z:", style: Theme.of(context).textTheme.featuresValueBold),
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
                        Text("GK", style: Theme.of(context).textTheme.featuresHeadline,),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "X:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Y:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Z:", style: Theme.of(context).textTheme.featuresValueBold),
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
                        Text("GS", style: Theme.of(context).textTheme.featuresHeadline,),
                        Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "X:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Y:", style: Theme.of(context).textTheme.featuresValueBold),
                                  TextSpan(text: " 0.0"),
                                ]
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.featuresValue,
                                children: [
                                  TextSpan(text: "Z:", style: Theme.of(context).textTheme.featuresValueBold),
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
        ),
      ),
    );
  }
}
