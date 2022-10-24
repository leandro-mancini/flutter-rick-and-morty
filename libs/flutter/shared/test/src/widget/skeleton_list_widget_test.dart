import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/skeleton_list_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const SkeletonListWidget skeletonListWidget = SkeletonListWidget(
      key: widgetKey,
      isLoading: true,
      child: Text('The Rick and Morty'),
    );

    const TestApp app = TestApp(skeletonListWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsNothing);

    expect(app.skeletonListWidget.isLoading, true);
    expect(app.skeletonListWidget.itemCount, 5);
    expect(app.skeletonListWidget.hasLeading, true);
  });

  testWidgets('should create the widget with text', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const SkeletonListWidget skeletonListWidget = SkeletonListWidget(
      key: widgetKey,
      isLoading: false,
      child: Text('The Rick and Morty'),
    );

    const TestApp app = TestApp(skeletonListWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsOneWidget);

    expect(app.skeletonListWidget.isLoading, false);
    expect(app.skeletonListWidget.itemCount, 5);
    expect(app.skeletonListWidget.hasLeading, true);
  });
  
}

class TestApp extends StatefulWidget {
  final SkeletonListWidget skeletonListWidget;

  const TestApp(this.skeletonListWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.skeletonListWidget,
      ),
    );
  }
}