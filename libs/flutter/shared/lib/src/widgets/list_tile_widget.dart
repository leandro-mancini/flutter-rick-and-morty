import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final ImageProvider? backgroundImage;
  final String title;
  final String subtitle;
  final bool hasLeading;
  final bool enabled;
  final GestureTapCallback? onTap;

  const ListTileWidget({
    Key? key,
    this.backgroundImage,
    required this.title,
    required this.subtitle,
    this.hasLeading = true,
    this.enabled = true,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: hasLeading ? CircleAvatar(
        backgroundImage: backgroundImage,
        backgroundColor: Colors.grey[300]
      ) : null,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),),
      subtitle: Text(subtitle),
      onTap: enabled ? () => onTap!() : null,
    );
  }
}