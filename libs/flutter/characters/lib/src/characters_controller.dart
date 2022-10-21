import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'characters_controller.g.dart';

var characterService = CharacterService();

class CharactersController = CharactersControllerBase with _$CharactersController;

abstract class CharactersControllerBase with Store {
  @observable
  List<Character> characters = <Character>[];

  @observable
  bool hasCharacters = false;

  @action
  getAllCharacters() async {
    characters = await characterService.getAllCharacters();
    hasCharacters = true;
  }

  @action
  getFilteredCharacters(CharacterFilters filters) async {
    hasCharacters = false;

    characters = await characterService.getFilteredCharacters(filters);

    hasCharacters = true;
  }
}