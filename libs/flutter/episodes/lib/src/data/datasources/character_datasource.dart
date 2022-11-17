
import '../models/character_model.dart';

abstract class ICharacterDataSource {
  Future<List<CharacterModel>> getListOfCharacters(List<int> ids);
}