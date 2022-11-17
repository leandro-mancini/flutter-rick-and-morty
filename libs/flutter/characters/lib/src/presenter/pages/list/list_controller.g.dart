// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListController on ListControllerBase, Store {
  late final _$allCharactersAtom =
      Atom(name: 'ListControllerBase.allCharacters', context: context);

  @override
  List<CharacterEntity> get allCharacters {
    _$allCharactersAtom.reportRead();
    return super.allCharacters;
  }

  @override
  set allCharacters(List<CharacterEntity> value) {
    _$allCharactersAtom.reportWrite(value, super.allCharacters, () {
      super.allCharacters = value;
    });
  }

  late final _$charactersAtom =
      Atom(name: 'ListControllerBase.characters', context: context);

  @override
  List<CharacterEntity> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<CharacterEntity> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$hasCharactersAtom =
      Atom(name: 'ListControllerBase.hasCharacters', context: context);

  @override
  bool get hasCharacters {
    _$hasCharactersAtom.reportRead();
    return super.hasCharacters;
  }

  @override
  set hasCharacters(bool value) {
    _$hasCharactersAtom.reportWrite(value, super.hasCharacters, () {
      super.hasCharacters = value;
    });
  }

  late final _$hasFilterCharactersAtom =
      Atom(name: 'ListControllerBase.hasFilterCharacters', context: context);

  @override
  bool get hasFilterCharacters {
    _$hasFilterCharactersAtom.reportRead();
    return super.hasFilterCharacters;
  }

  @override
  set hasFilterCharacters(bool value) {
    _$hasFilterCharactersAtom.reportWrite(value, super.hasFilterCharacters, () {
      super.hasFilterCharacters = value;
    });
  }

  late final _$getAllCharactersAsyncAction =
      AsyncAction('ListControllerBase.getAllCharacters', context: context);

  @override
  Future getAllCharacters() {
    return _$getAllCharactersAsyncAction.run(() => super.getAllCharacters());
  }

  late final _$getFilteredToCharacterAsyncAction = AsyncAction(
      'ListControllerBase.getFilteredToCharacter',
      context: context);

  @override
  Future getFilteredToCharacter(String value) {
    return _$getFilteredToCharacterAsyncAction
        .run(() => super.getFilteredToCharacter(value));
  }

  @override
  String toString() {
    return '''
allCharacters: ${allCharacters},
characters: ${characters},
hasCharacters: ${hasCharacters},
hasFilterCharacters: ${hasFilterCharacters}
    ''';
  }
}
