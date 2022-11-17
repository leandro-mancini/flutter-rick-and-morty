import 'package:flutter_characters/src/domain/entities/character_entity.dart';

import '../repositories/get_favorites.dart';

abstract class IPostFavorite {
  void call(CharacterEntity character);
}

class PostFavorite implements IPostFavorite {
  final IGetFavoritesRepository repository;

  PostFavorite(this.repository);

  @override
  void call(CharacterEntity character) async {
    repository.setFavorite(character);
  }

}