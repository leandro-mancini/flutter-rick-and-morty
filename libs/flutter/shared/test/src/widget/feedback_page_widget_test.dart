import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/feedback_page_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const message = 'Feedback Page';
  const description = 'Descrição feedback page';

  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const FeedbackPageWidget feedbackPageWidget = FeedbackPageWidget(
      key: widgetKey,
      message: message,
    );

    const TestApp app = TestApp(feedbackPageWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text(message), findsOneWidget);
    expect(find.text(description), findsNothing);
    expect(find.byType(TextButton), findsNothing);

    expect(app.feedbackPageWidget.message, message);
    expect(app.feedbackPageWidget.enabledAction, false);
  });

  testWidgets('should create the widget with description', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    const FeedbackPageWidget feedbackPageWidget = FeedbackPageWidget(
      key: widgetKey,
      message: message,
      description: description,
    );

    const TestApp app = TestApp(feedbackPageWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text(message), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);

    expect(app.feedbackPageWidget.message, message);
    expect(app.feedbackPageWidget.description, description);
    expect(app.feedbackPageWidget.enabledAction, false);
  });

  testWidgets('should create the widget with description and button', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');
    const textButton = 'Clique aqui';

    var currentValue = 0;

    FeedbackPageWidget feedbackPageWidget = FeedbackPageWidget(
      key: widgetKey,
      message: message,
      description: description,
      enabledAction: true,
      textButton: textButton,
      onPressed: () => currentValue++,
    );

    final TestApp app = TestApp(feedbackPageWidget);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
    expect(find.text(message), findsOneWidget);
    expect(find.text(description), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text(textButton), findsOneWidget);

    expect(app.feedbackPageWidget.message, message);
    expect(app.feedbackPageWidget.description, description);
    expect(app.feedbackPageWidget.enabledAction, true);
    expect(app.feedbackPageWidget.textButton, textButton);

    await tester.tap(find.byType(TextButton));
    await tester.pump();

    expect(currentValue, 1);
  });
}

class TestApp extends StatefulWidget {
  final FeedbackPageWidget feedbackPageWidget;

  const TestApp(this.feedbackPageWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.feedbackPageWidget,
      ),
    );
  }
}