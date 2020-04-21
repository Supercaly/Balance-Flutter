
import 'package:balance_app/widgets/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group("Check selected", () {
    testWidgets("only one item selected", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: DotsIndicator(
            size: 3,
            selected: 0,
          ),
        )
      );

      expect(ContainerHasColor(Colors.white), findsOneWidget);
      expect(ContainerHasColor(Colors.white38), findsNWidgets(2));
    });

    testWidgets("change selection", (tester) async {
      int selected = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: DotsIndicator(
            size: 2,
            selected: selected,
          ),
        )
      );

      expect(ContainerHasColor(Colors.white), findsOneWidget);
      expect(ContainerHasColor(Colors.white38), findsOneWidget);

      selected = 1;
      await tester.pumpAndSettle();
      expect(ContainerHasColor(Colors.white), findsOneWidget);
      expect(ContainerHasColor(Colors.white38), findsOneWidget);
    });
  });

  group("Check assertions", () {
    testWidgets("size should be greather that 0", (tester) async {
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: DotsIndicator(
              size: 0,
            ),
          )
        );
        fail("The size sould not be <= 0");
      } on AssertionError catch (e) {
        expect(e.toString(), contains("size > 0"));
      }
    });

    testWidgets("selected should be greather or equal to 0", (tester) async {
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: DotsIndicator(
              selected: -1,
            ),
          )
        );
        fail("The selected sould not be < 0");
      } on AssertionError catch (e) {
        expect(e.toString(), contains("selected >= 0"));
      }
    });

    testWidgets("selected should be less that the size", (tester) async {
      try {
        await tester.pumpWidget(
          MaterialApp(
            home: DotsIndicator(
              size: 3,
              selected: 5,
            ),
          )
        );
        fail("The selected sould not be > size");
      } on AssertionError catch (e) {
        expect(e.toString(), contains("selected < size"));
      }
    });
  });
}

/// [MatchFinder] that finds all the [Container]s with
/// the given [color]
class ContainerHasColor extends MatchFinder {
  ContainerHasColor(
    this.color,
    { bool skipOffstage = true }
    ): super(skipOffstage: skipOffstage);

  final Color color;

  @override
  String get description => 'Container{color: "$color"}';

  @override
  bool matches(Element candidate) {
    if (candidate.widget is Container) {
      final Container container = candidate.widget;
      if (container.decoration is BoxDecoration) {
        final BoxDecoration boxDecoration = container.decoration;
        return boxDecoration.color == color;
      }
    }
    return false;
  }
}