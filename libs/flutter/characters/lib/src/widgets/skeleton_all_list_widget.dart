import 'package:flutter/material.dart';

class SkeletonAllListWidget extends StatelessWidget {
  const SkeletonAllListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}