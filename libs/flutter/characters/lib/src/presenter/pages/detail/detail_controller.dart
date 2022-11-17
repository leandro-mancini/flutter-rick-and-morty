import 'dart:developer';

import 'package:flutter_characters/src/domain/usecases/delete_favorite.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../../../domain/entities/character_entity.dart';
import '../../../domain/entities/episode_entity.dart';
import '../../../domain/usecases/get_all_favorite.dart';
import '../../../domain/usecases/get_character.dart';
import '../../../domain/usecases/get_character_episodes.dart';
import '../../../domain/usecases/post_favorite.dart';

part 'detail_controller.g.dart';

class DetailController = DetailControllerBase with _$DetailController;

abstract class DetailControllerBase with Store {
  final IGetCharacterUseCase _getCharacterUseCase;
  final IGetCharacterEpisodesUseCase _getCharacterEpisodesUseCase;
  final GetAllFavoritesUseCase _getAllFavoritesUseCase;
  final IPostFavorite _postFavorite;
  final IDeleteFavorite _deleteFavorite;

  @observable
  dynamic character;

  @observable
  bool hasCharacter = false;

  @observable
  List<EpisodeEntity> episodes = <EpisodeEntity>[];

  @observable
  bool hasEpisodes = false;

  @observable
  List<CharacterEntity> favorites = <CharacterEntity>[];

  @observable
  bool hasFavorite = false;

  DetailControllerBase(this._getCharacterUseCase, this._getCharacterEpisodesUseCase, this._getAllFavoritesUseCase, this._postFavorite, this._deleteFavorite);

  @action
  getCharacter(String id) async {
    hasCharacter = false;

    var result = await _getCharacterUseCase.call(id);

    result.fold((l) => log('OPS! Deu erro ao carregar os detalhes do personagem'), (CharacterEntity r) {
      character = r;

      List<int> ids = getIds(r.episode);

      getAllFavorites();
      checkIsFavorite(r);
      getListOfEpisodes(ids);
    });

    hasCharacter = true;
  }

  @action
  getListOfEpisodes(List<int> ids) async {
    var result = await _getCharacterEpisodesUseCase.call(ids);

    result.fold((l) => log('OPS! Deu erro a lista de episódios do personagem'), (r) => episodes = r);

    hasEpisodes = true;
  }

  @action
  getAllFavorites() async {
    var result = await _getAllFavoritesUseCase.call();

    result.fold((l) => log('OPS! Deu erro ao carregar a lista de favoritos'), (r) => favorites = r);
  }

  @action
  addCharacterToFavorite(CharacterEntity character, bool isFavorite) async {
    hasFavorite = !isFavorite;

    if (!isFavorite) {
      _postFavorite.call(character);
    } else {
      _deleteFavorite.call(character);
    }

    await getAllFavorites();
  }

  @action
  checkIsFavorite(CharacterEntity character) async {
    await getAllFavorites();

    var contain = favorites.where((element) => element.id == character.id);

    hasFavorite = contain.isEmpty ? false : true;
  }

  List<int> getIds(List<String> episodes) {
    List<int> ids = episodes.map((url) {
      var items = url.split('/');
      var id = items[items.length -1];

      return int.parse(id);
    }).toList();

    return ids;
  }
}