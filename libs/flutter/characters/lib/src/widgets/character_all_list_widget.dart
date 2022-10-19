import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/widgets/feedback_widget.dart';
import 'package:flutter_characters/src/widgets/skeleton_all_list_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

var characterService = CharacterService();

class CharacterAllListWidget extends StatelessWidget {
  const CharacterAllListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: characterService.getAllCharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SkeletonAllListWidget();
        } else if (snapshot.hasError || snapshot.data == null) {
          return const FeedbackWidget(message: 'Ops! ocorreu um erro ao carregar os dados. Tente novamente por favor!');
        }

        var characters = snapshot.data!;

        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: characters.length,
              (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(characters[index].image),
                    backgroundColor: Colors.grey[300]
                  ),
                  title: Text(characters[index].name),
                  subtitle: Text(characters[index].species),
                  onTap: () => Modular.to.pushNamed('/character/${characters[index].id}'),
                );
              }
            ),
          ),
        );
      },
    );
  }
}