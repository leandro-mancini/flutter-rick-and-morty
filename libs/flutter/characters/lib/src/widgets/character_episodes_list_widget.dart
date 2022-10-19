import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/widgets/episode_card_widget.dart';

var episodeService = EpisodeService();

class CharacterEpisodesListWidget extends StatelessWidget {
  final List<String> episode;

  const CharacterEpisodesListWidget({Key? key, required this.episode}) : super(key: key);

  List<int> _getIds() {
    List<int> ids = episode.map((url) {
      var items = url.split('/');
      var id = items[items.length -1];

      return int.parse(id);
    }).toList();

    return ids;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      future: episodeService.getListOfEpisodes(_getIds()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Text('Ops! ocorreu um erro ao carregar os dados. Tente novamente por favor!');
        }

        var episodeList = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: episodeList.map((item) {
              return EpisodeCardWidget(
                episode: item.episode,
                id: item.id,
                name: item.name,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}