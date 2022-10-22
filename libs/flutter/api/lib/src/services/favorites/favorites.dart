import 'dart:convert';

import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_api/src/shared/shared_pref.dart';

SharedPref sharedPref = SharedPref();

class FavoriteService {
  static const String favCharactersKey = 'favCharacters';
  static List<Character> favCharacters = <Character>[];

  Future<List<Character>> getFavoriteCharacters() async {
    String favorites = await SharedPref.getString(favCharactersKey);

    if (favorites != '') {
      List<dynamic> json = jsonDecode(favorites);
      List<Character> characters = List<Character>.from(json.map((x) => Character.fromJson(x)));

      return characters;
    }

    return [];
  }

  void addCharacterToFavorite(Character character) async {
    favCharacters = await getFavoriteCharacters();

    favCharacters.add(character);

    SharedPref.setString(favCharactersKey, jsonEncode(favCharacters));
  }

  void removeCharacterToFavorite(Character character) async {
    favCharacters = await getFavoriteCharacters();
    
    favCharacters.removeWhere((element) => element.id == character.id);

    SharedPref.setString(favCharactersKey, jsonEncode(favCharacters));
  }
}