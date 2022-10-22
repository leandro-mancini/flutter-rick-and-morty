import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Widget skeleton;

  const SkeletonWidget({Key? key, required this.child, required this.isLoading, required this.skeleton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      duration: const Duration(milliseconds: 1500),
      shimmerGradient: LinearGradient(
        colors: [
          Colors.grey.shade100,
          Colors.grey.shade200,
          Colors.grey.shade200,
          Colors.grey.shade100,
        ],
        stops: const [0.0, 0.3, 1, 1,],
        begin: const Alignment(-1, 0),
        end: const Alignment(1, 0),
      ),
      isLoading: isLoading,
      skeleton: skeleton,
      child: child
    );
  }
}