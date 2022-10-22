import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'detail_controller.g.dart';

var characterService = CharacterService();
var episodeService = EpisodeService();
var favoritesService = FavoriteService();

class DetailController = DetailControllerBase with _$DetailController;

abstract class DetailControllerBase with Store {
  @observable
  dynamic character;

  @observable
  bool hasCharacter = false;

  @observable
  List<Episode> episodes = <Episode>[];

  @observable
  bool hasEpisodes = false;

  @observable
  List<Character> favorites = <Character>[];

  @observable
  bool hasFavorite = false;

  @action
  getCharacter(String id) async {
    character = await characterService.getCharacter(id);

    hasCharacter = true;

    return character;
  }

  @action
  getListOfEpisodes(List<int> ids) async {
    episodes = await episodeService.getListOfEpisodes(ids);

    hasEpisodes = true;
  }

  @action
  getFavorites() async {
    favorites = await favoritesService.getFavoriteCharacters();
  }

  @action
  addCharacterToFavorite(Character character, bool isFavorite) async {
    hasFavorite = !isFavorite;

    if (!isFavorite) {
      favoritesService.addCharacterToFavorite(character);
    } else {
      favoritesService.removeCharacterToFavorite(character);
    }

    await getFavorites();
  }

  @action
  checkCharacterFavorite(Character character) async {
    await getFavorites();

    var contain = favorites.where((element) => element.id == character.id);

    hasFavorite = contain.isEmpty ? false : true;
  }
}