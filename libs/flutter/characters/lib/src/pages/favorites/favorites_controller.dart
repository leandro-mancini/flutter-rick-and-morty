import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'favorites_controller.g.dart';

var favoritesService = FavoriteService();

class FavoriteController = FavoriteControllerBase with _$FavoriteController;

abstract class FavoriteControllerBase with Store {
  @observable
  bool hasFavorites = false;

  @observable
  bool hasFilterFavorites = false;

  @observable
  List<Character> allFavorites = <Character>[];

  @observable
  List<Character> favorites = <Character>[];

  @action
  getFavorites() async {
    allFavorites = await favoritesService.getFavoriteCharacters();
    favorites = allFavorites;
    hasFavorites = true;
  }

  @action
  getFilteredToFavorite(String value) async {
    if (value.isEmpty) {
      hasFilterFavorites = false;
      favorites = allFavorites;
    } else {
      List<Character> searchFavorite = allFavorites
        .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

      hasFilterFavorites = true;
      favorites = searchFavorite;
    }
  }
}