import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackPageWidget extends StatelessWidget {
  final String illustration;
  final String message;

  const FeedbackPageWidget({Key? key, required this.message, required this.illustration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              illustration,
              width: 200,
              height: 200,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}