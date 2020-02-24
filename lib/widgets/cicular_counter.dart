import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'dart:math' as Math;

import 'counter_state.dart';

class MeasureCountdown extends StatefulWidget {

  final Function onPreCountdown;
  final Function onMeasureStart;
  final Function onMeasureCancel;
  final Function onMeasureDone;

  MeasureCountdown({this.onPreCountdown, this.onMeasureStart, this.onMeasureCancel, this.onMeasureDone});

  @override
  _MeasureCountdownState createState() => _MeasureCountdownState();
}

class _MeasureCountdownState extends State<MeasureCountdown> {
  CounterState _counterState;
  Duration _counterDuration;
  Timer _timer;

  @override
  void initState() {
    _counterState = CounterState.IDLE;
    _counterDuration = Duration(seconds: 5);
    super.initState();
  }

  @override
  void didUpdateWidget(MeasureCountdown oldWidget) {
    _counterDuration = Duration(seconds: _counterState == CounterState.MEASURE? 32: 5);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          (_counterState == CounterState.IDLE)?
            Placeholder(
              fallbackWidth: 200,
              fallbackHeight: 200,
            ):
            CircularCounter(counterState: _counterState),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              switch(_counterState) {
                case CounterState.IDLE:
                  widget.onPreCountdown();
                  setState(() => _counterState = CounterState.PRE_MEASURE);
                  CountdownTimer(_counterDuration, Duration(seconds: 1))
                    .listen((event) {
                      print("Ciao... $event");
                  },
                    onDone: () {
                      setState(() {
                        if (_counterState == CounterState.PRE_MEASURE) {
                          widget.onMeasureStart();
                          _counterState = CounterState.MEASURE;
                        } else {
                          widget.onMeasureDone();
                          _counterState = CounterState.IDLE;
                        }
                      });
                    },
                    onError: (error) => print("Error"),
                  );
                  break;
                case CounterState.PRE_MEASURE:
                case CounterState.MEASURE:
                  setState(() => _counterState = CounterState.IDLE);
                  widget.onMeasureCancel();
                  _timer?.cancel();
                  _timer = null;
                  break;
              }
            },
            color: Theme.of(context).accentColor,
            child: Text(
              _counterState == CounterState.IDLE? "START TEST": "STOP TEST", style: TextStyle(color: Colors.white),
            )
          ),
        ]
      ),
    );
  }
}


/// Enum class representing the direction
/// (mode) in which the CircularCounter
/// will fill
///
/// - normal, fill from left to right
/// - reverse, fill from right to left
enum FillMode {NORMAL, REVERSE}

/// Widget containing the logic for the circular counter
class CircularCounter extends StatefulWidget {
  final CounterState counterState;

  CircularCounter({this.counterState});

  @override
  State<StatefulWidget> createState() {
    return _CircularCounterState();
  }
}

/// State of the CircularCounter widget
class _CircularCounterState extends State<CircularCounter> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  FillMode _fillMode;

  @override
  void initState() {
    _fillMode = (widget.counterState == CounterState.MEASURE)? FillMode.NORMAL: FillMode.REVERSE;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5)
    );
    super.initState();
  }

  @override
  void didUpdateWidget(CircularCounter oldWidget) {
    print("_CircularCounterState.didUpdateWidget: $oldWidget");
    // Change the fill mode and duration of the animation accordingly to the state
    _fillMode = (widget.counterState == CounterState.MEASURE)? FillMode.NORMAL: FillMode.REVERSE;
    _controller.duration = Duration(seconds: (widget.counterState == CounterState.MEASURE)? 32: 5);
    // Start/Stop the progress animation accordingly to the state
    if (widget.counterState == CounterState.IDLE) {
      _controller.reset();
      print("Stop Counter Animation!");
    }
    else {
      _controller.forward();
      print("Start Counter Animation!");
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        FittedBox(
          child: SizedBox(
            width: 220,
            height: 220,
            child: CustomPaint(
              painter: TimerPainter(
                animation: _controller,
                bgColor: themeData.scaffoldBackgroundColor,
                color: themeData.primaryColor,
                fillMode: FillMode.REVERSE,
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => RichText(
            text: TextSpan(
              text: timeString,
              style: themeData.textTheme.headline2.copyWith(
                color: themeData.primaryColor
              ),
              children: [
                TextSpan(
                  text: " sec",
                  style: themeData.textTheme.headline6.copyWith(
                    color: themeData.primaryColor
                  )
                )
              ]
            )
          )
        )
      ]
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Return the formatted string to display in the counter text
  String get timeString {
    Duration duration = _fillMode == FillMode.REVERSE?
      (Duration(seconds: 1) + _controller.duration) - _controller.duration * _controller.value:
      _controller.duration * _controller.value;
    // TODO: 22/02/20 If the seconds are more than 60 the string will wrap back to 0
    return "${(duration.inSeconds % 60).toString().padLeft(2, "0")}";
  }
}

/// Class representing the Circular Counter
class TimerPainter extends CustomPainter {
  /// Start position of the arc in radians
  static const START_RAD = 2.35619;
  /// Length of the arc in radians
  static const SWIPE_RAD = 4.71239;

  /// Animation object used to time the arc filling
  final Animation<double> animation;
  /// Color of the background
  final Color bgColor;
  /// Color of the arc
  final Color color;
  /// Represent the chosen fill mode
  final FillMode fillMode;

  TimerPainter({
    this.animation,
    this.bgColor,
    this.color,
    this.fillMode = FillMode.NORMAL,
  }): super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = bgColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final radius = Math.min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Draw the background arc
    canvas.drawArc(rect, START_RAD, SWIPE_RAD, false, paint);
    paint.color = color;
    // Compute the current sweep angle and draw the main arc
    double progress = (this.fillMode == FillMode.NORMAL)?
        SWIPE_RAD * animation.value :
        SWIPE_RAD - SWIPE_RAD * animation.value;
    canvas.drawArc(rect, START_RAD, progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
      color != old.color ||
      bgColor != old.bgColor ||
      fillMode != old.fillMode;
  }
}