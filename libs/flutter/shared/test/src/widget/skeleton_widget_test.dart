import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/skeleton_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skeletons/skeletons.dart';

void main() {
  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    final SkeletonWidget skeletonWidget = SkeletonWidget(
      key: widgetKey,
      isLoading: true,
      skeleton: SkeletonListView(),
      child: const Text('The Rick and Morty'),
    );

    final TestApp app = TestApp(skeletonWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsNothing);

    expect(app.skeletonWidget.isLoading, true);
  });

  testWidgets('should create the widget with text', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    final SkeletonWidget skeletonWidget = SkeletonWidget(
      key: widgetKey,
      isLoading: false,
      skeleton: SkeletonListView(),
      child: const Text('The Rick and Morty'),
    );

    final TestApp app = TestApp(skeletonWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsOneWidget);

    expect(app.skeletonWidget.isLoading, false);
  });
}

class TestApp extends StatefulWidget {
  final SkeletonWidget skeletonWidget;

  const TestApp(this.skeletonWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.skeletonWidget,
      ),
    );
  }
}