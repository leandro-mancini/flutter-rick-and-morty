import 'dart:developer';

import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../../../domain/usecases/get_filtered_characters.dart';

part 'search_controller.g.dart';

class SearchController = SearchControllerBase with _$SearchController;

abstract class SearchControllerBase with Store {
  final GetFilteredCharactersUseCase _getFilteredCharactersUseCase;
  
  @observable
  List<CharacterEntity> allCharacters = <CharacterEntity>[];

  @observable
  List<CharacterEntity> characters = <CharacterEntity>[];

  @observable
  bool hasCharacters = false;

  @observable
  bool hasFilterCharacters = false;

  SearchControllerBase(this._getFilteredCharactersUseCase);

  @action
  getFilteredCharacters(String name) async {
    allCharacters = [];

    hasCharacters = false;
    
    var result = await _getFilteredCharactersUseCase.call(CharacterFilters(name: name));
    
    result.fold((l) => log('OPS! Deu erro ao carregar o filtro de personagem'), (r) => allCharacters = r);

    characters = allCharacters;
    hasCharacters = true;
  }

  @action
  getFilteredToSearchCharacter(String value) async {
    if (value.isEmpty) {
      hasFilterCharacters = false;
      characters = allCharacters;
    } else {
      List<CharacterEntity> searchCharacter = allCharacters
        .where((element) => element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();

      hasFilterCharacters = true;
      characters = searchCharacter;
    }
  }
}