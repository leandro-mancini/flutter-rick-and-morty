import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackPageWidget extends StatelessWidget {
  final String illustration;
  final String message;
  final String? description;
  final String? textButton;
  final bool enabledAction;
  final VoidCallback? onPressed;

  const FeedbackPageWidget({
    Key? key,
    required this.message,
    required this.illustration,
    this.description,
    this.onPressed,
    this.enabledAction = false,
    this.textButton
  }) : super(key: key);

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
            ),
            description != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ) : Container(),
            enabledAction ? TextButton(
              onPressed: () => onPressed!(),
              child: Text(textButton!, style: const TextStyle(color: Colors.red),)
            ) : Container(),
          ],
        ),
      ),
    );
  }
}