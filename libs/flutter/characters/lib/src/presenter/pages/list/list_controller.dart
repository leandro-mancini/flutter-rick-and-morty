
import 'dart:developer';

import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../../../domain/usecases/get_all_characters.dart';
import '../../../domain/usecases/get_filtered_characters.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  final GetAllCharactersUseCase _getAllCharactersUseCase;
  final GetFilteredCharactersUseCase _getFilteredCharactersUseCase;

  ListControllerBase(this._getAllCharactersUseCase, this._getFilteredCharactersUseCase);

  @observable
  List<CharacterEntity> allCharacters = <CharacterEntity>[];

  @observable
  List<CharacterEntity> characters = <CharacterEntity>[];

  @observable
  bool hasCharacters = false;

  @observable
  bool hasFilterCharacters = false;

  @action
  getAllCharacters() async {
    hasCharacters = false;

    var result = await _getAllCharactersUseCase.call();

    result.fold((l) => log('OPS! Deu erro ao carregar os personagens'), (r) => allCharacters = r);

    characters = allCharacters;

    hasCharacters = true;
  }

  @action
  getFilteredToCharacter(String value) async {
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

  getFilteredCharacters(CharacterFilters filters) async {
    hasCharacters = false;

    var result = await _getFilteredCharactersUseCase.call(filters);

    result.fold((l) => log('OPS! Deu erro ao carregar o filtro de personagem'), (r) => allCharacters = r);

    characters = allCharacters;

    hasCharacters = true;
  }
}