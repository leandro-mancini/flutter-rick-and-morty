import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'search_controller.g.dart';

var characterService = CharacterService();

class SearchController = SearchControllerBase with _$SearchController;

abstract class SearchControllerBase with Store {
  @observable
  List<Character> allCharacters = <Character>[];

  @observable
  List<Character> characters = <Character>[];

  @observable
  bool hasCharacters = false;

  @observable
  bool hasFilterCharacters = false;

  @action
  getFilteredCharacters(String name) async {
    hasCharacters = true;
    allCharacters = await characterService.getFilteredCharacters(CharacterFilters(name: name));
    characters = allCharacters;
    hasCharacters = true;
  }

  @action
  getFilteredToSearchCharacter(String value) async {
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