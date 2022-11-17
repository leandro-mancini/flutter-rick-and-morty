import 'package:flutter_characters/src/domain/entities/character_entity.dart';

import '../repositories/get_favorites.dart';

abstract class IDeleteFavorite {
  void call(CharacterEntity character);
}

class DeleteFavorite implements IDeleteFavorite {
  final IGetFavoritesRepository repository;

  DeleteFavorite(this.repository);

  @override
  void call(CharacterEntity character) {
    repository.deleteFavorite(character);
  }

}
