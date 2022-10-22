import 'package:flutter/material.dart';

class GenereicLabelWidget extends StatelessWidget {
  final String label;

  const GenereicLabelWidget({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(right: 10, top: 10),
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
      ),
    );
  }
}