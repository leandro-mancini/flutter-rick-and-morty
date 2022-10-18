import 'package:flutter/material.dart';

class CharacterAllListWidget extends StatelessWidget {
  const CharacterAllListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 100,
          (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300]
              ),
              title: const Text('Personagem'),
              subtitle: const Text('Descrição personagem'),
              onTap: () => print('Clicou em avatar $index'),
            );
          }
        ),
      ),
    );
  }
}