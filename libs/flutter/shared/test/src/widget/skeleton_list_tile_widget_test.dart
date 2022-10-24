import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/skeleton_list_tile_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const SkeletonListTileWidget skeletonListTileWidget = SkeletonListTileWidget(
      key: widgetKey,
      isLoading: true,
      child: Text('The Rick and Morty'),
    );

    const TestApp app = TestApp(skeletonListTileWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsNothing);

    expect(app.skeletonListTileWidget.isLoading, true);
  });

  testWidgets('should create the widget with text', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const SkeletonListTileWidget skeletonListTileWidget = SkeletonListTileWidget(
      key: widgetKey,
      isLoading: false,
      child: Text('The Rick and Morty'),
    );

    const TestApp app = TestApp(skeletonListTileWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text('The Rick and Morty'), findsOneWidget);

    expect(app.skeletonListTileWidget.isLoading, false);
  });
  
}

class TestApp extends StatefulWidget {
  final SkeletonListTileWidget skeletonListTileWidget;

  const TestApp(this.skeletonListTileWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.skeletonListTileWidget,
      ),
    );
  }
}