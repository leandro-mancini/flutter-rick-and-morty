import 'package:flutter/material.dart';
import 'package:flutter_shared/flutter_shared.dart';

class ListCharactersWidget extends StatelessWidget {
  final bool isLoading;
  final int itemCount;
  final List<dynamic> characters;
  final Function(int)? onTap;

  const ListCharactersWidget({Key? key, required this.isLoading, required this.itemCount, required this.characters, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonListWidget(
      itemCount: 10,
      isLoading: !isLoading,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ListTileWidget(
            title: characters[index].name,
            subtitle: characters[index].species,
            backgroundImage: NetworkImage(characters[index].image),
            onTap: () => onTap!(index),
          );
        },
      ),
    );
  }
}