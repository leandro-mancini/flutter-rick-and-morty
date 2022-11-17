import 'package:flutter_commons/flutter_commons.dart';

import '../models/character_model.dart';

abstract class IGetCharactersDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<List<CharacterModel>> getFilteredCharacters(CharacterFilters filters);
  Future<CharacterModel> getCharacter(String id);
}