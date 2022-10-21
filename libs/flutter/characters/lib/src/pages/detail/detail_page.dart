import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/detail/detail_controller.dart';
import 'package:flutter_characters/src/widgets/character_episodes_list_widget.dart';
import 'package:flutter_characters/src/widgets/character_image_widget.dart';
import 'package:flutter_characters/src/widgets/character_info_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = DetailController();

  @override
  void initState() {
    detailController.getCharacter(widget.id);
    super.initState();
  }

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
        child: Observer(
          builder: (_) {
            return detailController.hasCharacter ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CharacterImageWidget(image: detailController.character.image),
                CharacterInfoWidget(
                  created: detailController.character.created,
                  gender: detailController.character.gender,
                  location: detailController.character.location,
                  name: detailController.character.name,
                  origin: detailController.character.origin,
                  species: detailController.character.species,
                  status: detailController.character.status,
                ),
                CharacterEpisodesListWidget(episode: detailController.character.episode,)
              ],
            ) : Container();
          },
        ),
      ),
    );
  }
}