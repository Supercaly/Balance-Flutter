
import 'package:balance_app/res/string.dart';
import 'package:flutter/material.dart';

/// Widget for displaying informations about open source dependencies
class OpenSourceScreen extends StatelessWidget {
  final dependenciesMap = [
    {
      "name": "path_provider",
      "version": "1.6.9",
      "description": "Flutter plugin for getting commonly used locations on the Android & iOS file systems, such as the temp and app data directories."
    },
    {
      "name": "flutter_bloc",
      "version": "4.0.0",
      "description": "Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package."
    },
    {
      "name": "floor",
      "version": "0.12.0",
      "description": "A supportive SQLite abstraction for your Flutter applications. This library is the runtime dependency."
    },
    {
      "name": "iirjdart",
      "version": "0.0.1",
      "description": "An IIR filter library written in Dart. Highpass, lowpass, bandpass and bandstop as Butterworth, Bessel and Chebyshev Type I/II."
    },
    {
      "name": "powerdart",
      "version": "0.0.2",
      "description": "Compute the Power Spectral Density (PSD) on Dart. This package runs everywhere dart runs."
    },
    {
      "name": "quiver",
      "version": "2.1.3",
      "description": "Quiver is a set of utility libraries for Dart that makes using many Dart libraries easier and more convenient, or adds additional functionality."
    },
    {
      "name": "shared_preferences",
      "version": "0.5.7+3",
      "description": "Flutter plugin for reading and writing simple key-value pairs. Wraps NSUserDefaults on iOS and SharedPreferences on Android."
    },
    {
      "name": "package_info",
      "version": "0.4.0+18",
      "description": "Flutter plugin for querying information about the application package, such as CFBundleVersion on iOS or versionCode on Android."
    },
    {
      "name": "circular_check_box",
      "version": "1.0.2",
      "description": "Same as the regular checkbox, but circular!"
    },
    {
      "name": "custom_dropdown",
      "version": "0.0.2",
      "description": "A simple dropdown library with custom style."
    },
    {
      "name": "vibration",
      "version": "1.2.4",
      "description": "A plugin for handling Vibration API on iOS and Android devices"
    },
    {
      "name": "audioplayers",
      "version": "0.15 .1",
      "description": "A flutter plugin to play multiple audio files simultaneously"
    },
    {
      "name": "charts_flutter",
      "version": "0.9.0",
      "description": "Material Design charting library for flutter."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BStrings.open_source_txt),
      ),
      body: ListView(
        children: dependenciesMap.map((e) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e["name"],
                  style: Theme.of(context).textTheme.headline5,
                ),
                Divider(),
                SizedBox(height: 4.0),
                Text(
                  e["description"],
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(height: 16.0),
                Text(
                  e["version"],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}