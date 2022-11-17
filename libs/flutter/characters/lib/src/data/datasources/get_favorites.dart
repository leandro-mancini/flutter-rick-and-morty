import '../models/character_model.dart';

abstract class IGetFavoritesDataSource {
  Future<List<CharacterModel>> getAllFavorites();
  void setFavorite(CharacterModel character);
  void deleteFavorite(CharacterModel character);
}