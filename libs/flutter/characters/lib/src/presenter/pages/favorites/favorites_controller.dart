import 'dart:developer';

import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../../../domain/usecases/get_all_favorite.dart';

part 'favorites_controller.g.dart';

class FavoritesController = FavoritesControllerBase with _$FavoritesController;

abstract class FavoritesControllerBase with Store {
  final GetAllFavoritesUseCase _getAllFavoritesUseCase;
  
  @observable
  bool hasFavorites = false;

  @observable
  bool hasFilterFavorites = false;

  @observable
  List<CharacterEntity> allFavorites = <CharacterEntity>[];

  @observable
  List<CharacterEntity> favorites = <CharacterEntity>[];

  FavoritesControllerBase(this._getAllFavoritesUseCase);

  @action
  getFavorites() async {
    var result = await _getAllFavoritesUseCase.call();

    result.fold((l) => log('OPS! Deu erro ao carregar a lista de favoritos'), (r) => allFavorites = r);
    
    favorites = allFavorites;
    hasFavorites = true;
  }

  @action
  getFilteredToFavorite(String value) async {
    if (value.isEmpty) {
      hasFilterFavorites = false;
      favorites = allFavorites;
    } else {
      List<CharacterEntity> searchFavorite = allFavorites
        .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

      hasFilterFavorites = true;
      favorites = searchFavorite;
    }
  }
}