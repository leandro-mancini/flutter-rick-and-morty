import 'dart:convert';

import 'package:flutter_characters/src/data/datasources/get_favorites.dart';
import 'package:flutter_characters/src/data/models/character_model.dart';
import 'package:flutter_commons/flutter_commons.dart';

String favoritesKey = 'favoritesKey';

class FavoritesDataSource implements IGetFavoritesDataSource {
  final ISharedPref pref;

  FavoritesDataSource(this.pref);

  static List<CharacterModel> favCharacters = <CharacterModel>[];

  @override
  Future<List<CharacterModel>> getAllFavorites() async {
    String favorites = await pref.getString(favoritesKey);

    if (favorites != '') {
      List<dynamic> json = jsonDecode(favorites);
      List<CharacterModel> characters = List<CharacterModel>.from(json.map((x) => CharacterModel.fromJson(x)));

      return characters;
    }

    return [];
  }
  
  @override
  void setFavorite(CharacterModel character) async {
    favCharacters = await getAllFavorites();

    favCharacters.add(character);

    pref.setString(favoritesKey, jsonEncode(favCharacters));
  }
  
  @override
  void deleteFavorite(CharacterModel character) async {
    favCharacters = await getAllFavorites();

    favCharacters.removeWhere((element) => element.id == character.id);

    pref.setString(favoritesKey, jsonEncode(favCharacters));
  }

}