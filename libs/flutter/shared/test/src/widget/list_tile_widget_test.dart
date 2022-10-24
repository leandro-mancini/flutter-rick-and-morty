import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const title = 'The Rick and Morty';
  const subtitle = 'API';
  const hasLeading = false;
  const enabled = false;

  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');
    const ListTileWidget listTileWidget = ListTileWidget(
      key: widgetKey,
      title: title,
      subtitle: subtitle,
    );

    const TestApp app = TestApp(listTileWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.text(subtitle), findsOneWidget);

    expect(app.listTileWidget.title, title);
    expect(app.listTileWidget.subtitle, subtitle);
    expect(app.listTileWidget.hasLeading, true);
    expect(app.listTileWidget.enabled, true);

    await tester.tap(find.byKey(widgetKey));
    await tester.pump();

    await tester.pumpWidget(app);
  });

  testWidgets('should have a widget of type CircleAvatar', (WidgetTester tester) async {
    const ListTileWidget listTileWidget = ListTileWidget(
      title: title,
      subtitle: subtitle
    );

    const TestApp app = TestApp(listTileWidget);

    await tester.pumpWidget(app);

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);

    expect(app.listTileWidget.title, title);
    expect(app.listTileWidget.subtitle, subtitle);
  });

  testWidgets('should not have a widget of type CircleAvatar', (WidgetTester tester) async {
    const ListTileWidget listTileWidget = ListTileWidget(
      title: title,
      subtitle: subtitle,
      hasLeading: hasLeading,
    );

    const TestApp app = TestApp(listTileWidget);

    await tester.pumpWidget(app);

    ListTile listTile = find.byType(ListTile).evaluate().single.widget as ListTile;

    expect(find.byWidget(listTile), findsOneWidget);
    expect(find.byType(CircleAvatar), findsNothing);

    expect(app.listTileWidget.title, title);
    expect(app.listTileWidget.subtitle, subtitle);
    expect(app.listTileWidget.hasLeading, hasLeading);
  });

  testWidgets('should click action widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    var currentValue = 0;

    final ListTileWidget listTileWidget = ListTileWidget(
      key: widgetKey,
      title: title,
      subtitle: subtitle,
      onTap: () => currentValue++,
    );

    final TestApp app = TestApp(listTileWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);

    expect(app.listTileWidget.title, title);
    expect(app.listTileWidget.subtitle, subtitle);

    await tester.tap(find.byKey(widgetKey));
    await tester.pump();

    expect(currentValue, 1);
  });

  testWidgets('should not click action widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    var currentValue = 0;

    const ListTileWidget listTileWidget = ListTileWidget(
      key: widgetKey,
      title: title,
      subtitle: subtitle,
      enabled: enabled
    );

    const TestApp app = TestApp(listTileWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);

    expect(app.listTileWidget.title, title);
    expect(app.listTileWidget.subtitle, subtitle);

    await tester.tap(find.byKey(widgetKey));
    await tester.pump();

    expect(currentValue, 0);
  });
}

class TestApp extends StatefulWidget {
  final ListTileWidget listTileWidget;

  const TestApp(this.listTileWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.listTileWidget,
      ),
    );
  }
}