import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/choice_chip_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<Filter> options = [
    Filter(label: 'Todos', value: 'empty'),
    Filter(label: 'Alive', value: 'alive'),
    Filter(label: 'Dead', value: 'dead'),
    Filter(label: 'unknown', value: 'unknown'),
  ];

  testWidgets('should create the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    ChoiceChipWidget choiceChipWidget = ChoiceChipWidget(
      key: widgetKey,
      options: options,
      onChange: (index) {},
    );

    final TestApp app = TestApp(choiceChipWidget);

    await tester.pumpWidget(app);

    var listChoice = tester.widgetList(find.byType(ChoiceChip));

    expect(listChoice.length, 4);

    expect(app.choiceChipWidget.options, options);
    expect(app.choiceChipWidget.options.length, 4);
    expect(app.choiceChipWidget.selectedIndex, 0);
  });

  testWidgets('should click the widget', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    var currentValue = '';

    ChoiceChipWidget choiceChipWidget = ChoiceChipWidget(
      key: widgetKey,
      options: options,
      onChange: (index) => currentValue = options[index].value,
    );

    final TestApp app = TestApp(choiceChipWidget);

    await tester.pumpWidget(app);

    var listChoice = tester.widgetList(find.byType(ChoiceChip));

    expect(listChoice.length, 4);

    expect(app.choiceChipWidget.options, options);
    expect(app.choiceChipWidget.options.length, 4);
    expect(app.choiceChipWidget.selectedIndex, 0);

    await tester.tap(find.text('Alive'));
    await tester.pump();

    expect(currentValue, 'alive');
  });

  testWidgets('should create the widget with value default', (WidgetTester tester) async {
    const widgetKey = Key('widgetKey');

    var currentValue = '';

    ChoiceChipWidget choiceChipWidget = ChoiceChipWidget(
      key: widgetKey,
      options: options,
      selectedIndex: 3,
      onChange: (index) => currentValue = options[index].value,
    );

    final TestApp app = TestApp(choiceChipWidget);

    await tester.pumpWidget(app);

    var listChoice = tester.widgetList(find.byType(ChoiceChip));

    expect(listChoice.length, 4);

    expect(app.choiceChipWidget.options, options);
    expect(app.choiceChipWidget.options.length, 4);
    expect(app.choiceChipWidget.selectedIndex, 3);

    await tester.tap(find.text('Alive'));
    await tester.pump();

    expect(currentValue, 'alive');
  });
}

class Filter {
  String? label;
  dynamic value;

  Filter({this.label, this.value});

  Filter.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}

class TestApp extends StatefulWidget {
  final ChoiceChipWidget choiceChipWidget;

  const TestApp(this.choiceChipWidget, {Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.choiceChipWidget,
      ),
    );
  }
}