import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatefulWidget {
  final List<dynamic> options;
  final Function(dynamic) onChange;

  const ChoiceChipWidget({Key? key, required this.options, required this.onChange}) : super(key: key);

  @override
  State<ChoiceChipWidget> createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  dynamic selectedIndex;
  List<dynamic> options = [];

  void onChangeChip() {
    
  }

  @override
  void initState() {
    super.initState();

    options = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chips = [];

    for (int i = 0; i < widget.options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: selectedIndex == i,
        label: Text(
          widget.options[i],
          style: TextStyle(
            color: selectedIndex == i ? Colors.white : Colors.grey[700],
          ),
        ),
        elevation: 0,
        pressElevation: 5,
        padding: const EdgeInsets.all(0),
        shadowColor: Colors.teal,
        backgroundColor: Colors.grey[300],
        selectedColor: Colors.red,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selectedIndex = i;
            }
          });

          widget.onChange(selectedIndex);
        },
      );

      chips.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: choiceChip
      ));
    }

    return Wrap(
      children: chips,
    );
  }
}