import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  final String message;

  const FeedbackWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(child: Text(message),)
    );
  }
}