import 'dart:developer';

import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_episodes/src/domain/entities/character_entity.dart';
import 'package:flutter_episodes/src/domain/entities/episode_entity.dart';
import 'package:flutter_episodes/src/domain/usecases/get_characters.dart';

import '../../../domain/usecases/get_episode.dart';

part 'detail_controller.g.dart';

class DetailController = DetailControllerBase with _$DetailController;

abstract class DetailControllerBase with Store {
  final IGetEpisodeUseCase episodeUseCase;
  final IGetCharactersUseCase charactersUseCase;

  @observable
  dynamic episode;

  @observable
  bool hasEpisode = false;

  @observable
  List<CharacterEntity> characters = <CharacterEntity>[];

  @observable
  bool hasCharacters = false;

  DetailControllerBase(this.episodeUseCase, this.charactersUseCase);

  @action
  getEpisode(String id) async {
    hasEpisode = false;

    var result = await episodeUseCase.call(id);

    result.fold((l) => log('OPS! Deu erro ao carregar o episódio'), (EpisodeEntity r) {
      episode = r;

      List<int> ids = getIds(r.characters);

      getListOfCharacters(ids);
    });

    hasEpisode = true;
  }

  @action
  getListOfCharacters(List<int> ids) async {
    hasCharacters = false;

    var result = await charactersUseCase.call(ids);

    result.fold((l) => log('OPS! Deu erro ao carregar a lista de personagens'), (r) => characters = r);

    hasCharacters = true;
  }

  List<int> getIds(List<String> list) {
    List<int> ids = list.map((url) {
      var items = url.split('/');
      var id = items[items.length -1];

      return int.parse(id);
    }).toList();

    return ids;
  }
}