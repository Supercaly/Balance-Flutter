
import 'package:balance_app/widgets/custom_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Correct initial selected", (tester) async{
    await tester.pumpWidget(
      MaterialApp(
        home: CustomToggleButton(
          leftText: Text("left"),
          rightText: Text("right"),
          onChanged: (_) {},
          initial: 0,
        )
      ),
    );

    // The buttons have their color?
    expect(MaterialHasColor(Colors.red.shade200), findsOneWidget);
    expect(MaterialHasColor(Colors.transparent), findsOneWidget);
    // Left button is the one selected?
    Material leftBtn = tester.firstWidget(find.widgetWithText(Material, "left"));
    expect(leftBtn.color, equals(Colors.red.shade200));
  });
  
  group("Check non null properties", () {
    testWidgets("left text cannot be null", (tester) async{
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: CustomToggleButton(
              leftText: null,
              rightText: Text("right"),
              onChanged: (_) {},
              initial: 0,
            )
          ),
        );
        fail("Creating a CustomToggleButton with null text should not be possible");
      } on AssertionError catch(e) {
        expect(e.toString(), contains("leftText != null"));
      }
    });

    testWidgets("right text cannot be null", (tester) async{
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: CustomToggleButton(
              leftText: Text("left"),
              rightText: null,
              onChanged: (_) {},
              initial: 0,
            )
          ),
        );
        fail("Creating a CustomToggleButton with null text should not be possible");
      } on AssertionError catch(e) {
        expect(e.toString(), contains("rightText != null"));
      }
    });
  });

  group("Check onChanged", () {
    testWidgets("onChanged is triggered on button press", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomToggleButton(
            leftText: Text("left"),
            rightText: Text("right"),
            onChanged: (_) {},
          ),
        )
      );

      expect(MaterialHasColor(Colors.red.shade200), findsOneWidget);
      expect(MaterialHasColor(Colors.transparent), findsOneWidget);
      Material leftBtn = tester.firstWidget(find.widgetWithText(Material, "left"));
      expect(leftBtn.color, equals(Colors.red.shade200));

      await tester.tap(find.text("right"));
      await tester.pumpAndSettle();

      // The selected button changed?
      expect(MaterialHasColor(Colors.red.shade200), findsOneWidget);
      expect(MaterialHasColor(Colors.transparent), findsOneWidget);
      Material rightBtn = tester.firstWidget(find.widgetWithText(Material, "right"));
      expect(rightBtn.color, equals(Colors.red.shade200));
    });

    testWidgets("onChanged that is null disables buttons", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomToggleButton(
            leftText: Text("left"),
            rightText: Text("right"),
            onChanged: null,
          ),
        ),
      );

      expect(MaterialHasColor(Colors.transparent), findsNWidgets(2));

      await tester.tap(find.text("right"));
      await tester.pumpAndSettle();

      // Nothing changed
      expect(MaterialHasColor(Colors.transparent), findsNWidgets(2));
    });
  });
}

/// [MatchFinder] that finds all the [Material]s with
/// the given [color]
class MaterialHasColor extends MatchFinder {
  MaterialHasColor(
    this.color,
    { bool skipOffstage = true }
  ): super(skipOffstage: skipOffstage);

  final Color color;

  @override
  String get description => 'Material{color: "$color"}';

  @override
  bool matches(Element candidate) {
    if (candidate.widget is Material) {
      final Material materialWidget = candidate.widget;
      return materialWidget.color == color;
    }
    return false;
  }
}