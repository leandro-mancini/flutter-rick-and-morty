import 'package:flutter/material.dart';
import 'package:flutter_shared/src/widgets/skeleton_widget.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonListWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final int? itemCount;
  final bool hasLeading;

  const SkeletonListWidget({
    Key? key,
    required this.child,
    required this.isLoading,
    this.itemCount = 5,
    this.hasLeading = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      isLoading: isLoading,
      skeleton: buildSkeletonView(),
      child: child
    );
  }

  Widget buildSkeletonView() {
    return SkeletonListView(
      itemCount: itemCount,
      item: SkeletonListTile(
        verticalSpacing: 12,
        hasLeading: hasLeading,
        leadingStyle: const SkeletonAvatarStyle(
          shape: BoxShape.circle
        ),
        titleStyle: SkeletonLineStyle(
          height: 16,
          minLength: 200,
          randomLength: true,
          borderRadius: BorderRadius.circular(12)
        ),
        subtitleStyle: SkeletonLineStyle(
          height: 12,
          maxLength: 200,
          randomLength: true,
          borderRadius: BorderRadius.circular(12)
        ),
        hasSubtitle: true,
      ),
    );
  }
}