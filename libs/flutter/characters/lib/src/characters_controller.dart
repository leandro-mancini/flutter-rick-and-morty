import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'characters_controller.g.dart';

var characterService = CharacterService();

class CharactersController = CharactersControllerBase with _$CharactersController;

abstract class CharactersControllerBase with Store {
  @observable
  List<Character> allCharacters = <Character>[];

  @observable
  List<Character> characters = <Character>[];

  @observable
  bool hasCharacters = false;

  @observable
  bool hasFilterCharacters = false;

  @action
  getAllCharacters() async {
    hasCharacters = false;
    allCharacters = await characterService.getAllCharacters();
    characters = allCharacters;
    hasCharacters = true;
  }

  @action
  getFilteredCharacters(CharacterFilters filters) async {
    hasCharacters = false;

    allCharacters = await characterService.getFilteredCharacters(filters);
    characters = allCharacters;

    hasCharacters = true;
  }

  @action
  getFilteredToCharacter(String value) async {
    if (value.isEmpty) {
      hasFilterCharacters = false;
      characters = allCharacters;
    } else {
      List<Character> searchCharacter = allCharacters
        .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

      hasFilterCharacters = true;
      characters = searchCharacter;
    }
  }
}