import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'search_controller.g.dart';

var characterService = CharacterService();

class SearchController = SearchControllerBase with _$SearchController;

abstract class SearchControllerBase with Store {
  @observable
  List<Character> characters = <Character>[];

  @observable
  bool hasCharacters = false;

  @action
  getFilteredCharacters(String name) async {
    characters = await characterService.getFilteredCharacters(CharacterFilters(name: name));

    hasCharacters = true;
  }
}