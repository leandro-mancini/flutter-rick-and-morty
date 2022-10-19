import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/widgets/character_episodes_list_widget.dart';
import 'package:flutter_characters/src/widgets/character_image_widget.dart';
import 'package:flutter_characters/src/widgets/character_info_widget.dart';
import 'package:flutter_characters/src/widgets/feedback_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

var characterService = CharacterService();

class CharacterDetailPage extends StatelessWidget {
  final String id;

  const CharacterDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Detalhe',
          style: TextStyle(
            color: Colors.black87
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () => Modular.to.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.black87,
            ),
            onPressed: () => print('Clicou em favoritar'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Character>(
          future: characterService.getCharacter(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (snapshot.hasError || snapshot.data == null) {
              return const FeedbackWidget(message: 'Ops! ocorreu um erro ao carregar os dados. Tente novamente por favor!');
            }

            var character = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CharacterImageWidget(image: character.image),
                CharacterInfoWidget(
                  created: character.created,
                  gender: character.gender,
                  location: character.location,
                  name: character.name,
                  origin: character.origin,
                  species: character.species,
                  status: character.status,
                ),
                CharacterEpisodesListWidget(episode: character.episode,)
              ],
            );
          },
        ),
      ),
    );
  }
}