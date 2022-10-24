import 'package:flutter/material.dart';
import 'package:flutter_splash/src/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should render a page', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');
    const SplashPage splashPage = SplashPage(key: widgetKey,);
    const TestApp app = TestApp(splashPage);

    await tester.pumpWidget(app);

    expect(find.byKey(widgetKey), findsOneWidget);
  });
}

class TestApp extends StatefulWidget {
  final SplashPage page;

  const TestApp(this.page, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.page,
      ),
    );
  }
}