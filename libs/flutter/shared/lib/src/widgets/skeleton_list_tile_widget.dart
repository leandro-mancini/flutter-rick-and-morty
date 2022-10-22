import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonListTileWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const SkeletonListTileWidget({Key? key, required this.child, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: isLoading,
      skeleton: buildSkeletonView(),
      child: child
    );
  }

  Widget buildSkeletonView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SkeletonListTile(
        hasSubtitle: true,
        hasLeading: false,
        contentSpacing: 0,
        verticalSpacing: 6,
        padding: const EdgeInsets.all(0),
        titleStyle: SkeletonLineStyle(borderRadius: BorderRadius.circular(16), height: 18,),
        subtitleStyle: SkeletonLineStyle(
          borderRadius: BorderRadius.circular(16),
          randomLength: true,
          maxLength: 128,
          height: 14
        ),
      ),
    );
  }
}