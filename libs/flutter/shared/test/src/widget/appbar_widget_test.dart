import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/appbar_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const AppBarWidget appBarWidget = AppBarWidget(
      key: widgetKey,
      title: 'AppBar',
    );

    const TestApp app = TestApp(appBarWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.byType(AppBar).first, findsOneWidget);
    expect(find.byType(AppBar).last, findsOneWidget);
    expect(find.text('AppBar'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    expect(app.choiceChipWidget.title, 'AppBar');
    expect(app.choiceChipWidget.automaticallyImplyLeading, true);
    expect(app.choiceChipWidget.showSearch, true);
  });

  testWidgets('should create the widget without search', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const AppBarWidget appBarWidget = AppBarWidget(
      key: widgetKey,
      title: 'AppBar',
      showSearch: false,
    );

    const TestApp app = TestApp(appBarWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.byType(AppBar).first, findsOneWidget);
    expect(find.byType(AppBar).last, findsOneWidget);
    expect(find.text('AppBar'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);

    expect(app.choiceChipWidget.title, 'AppBar');
    expect(app.choiceChipWidget.automaticallyImplyLeading, true);
    expect(app.choiceChipWidget.showSearch, false);
  });

  testWidgets('should assign a value', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    var currentValue = '';

    final AppBarWidget appBarWidget = AppBarWidget(
      key: widgetKey,
      title: 'AppBar',
      onChanged: (value) => currentValue = value,
    );

    final TestApp app = TestApp(appBarWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.byType(AppBar).first, findsOneWidget);
    expect(find.byType(AppBar).last, findsOneWidget);
    expect(find.text('AppBar'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    expect(app.choiceChipWidget.title, 'AppBar');
    expect(app.choiceChipWidget.automaticallyImplyLeading, true);
    expect(app.choiceChipWidget.showSearch, true);

    await tester.enterText(find.byType(TextField), 'flutter');

    await tester.pump();

    expect(currentValue, 'flutter');
  });
}

class TestApp extends StatefulWidget {
  final AppBarWidget choiceChipWidget;

  const TestApp(this.choiceChipWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: widget.choiceChipWidget,
      ),
    );
  }
}