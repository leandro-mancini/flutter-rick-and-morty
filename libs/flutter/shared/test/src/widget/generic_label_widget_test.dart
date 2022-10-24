import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/generic_label_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const GenereicLabelWidget genereicLabelWidget = GenereicLabelWidget(
      key: widgetKey,
      label: 'Human',
    );

    const TestApp app = TestApp(genereicLabelWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);

    expect(app.genereicLabelWidget.label, 'Human');
  });
}

class TestApp extends StatefulWidget {
  final GenereicLabelWidget genereicLabelWidget;

  const TestApp(this.genereicLabelWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.genereicLabelWidget,
      ),
    );
  }
}