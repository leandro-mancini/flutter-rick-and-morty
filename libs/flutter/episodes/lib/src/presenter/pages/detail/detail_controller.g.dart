// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailController on DetailControllerBase, Store {
  late final _$episodeAtom =
      Atom(name: 'DetailControllerBase.episode', context: context);

  @override
  dynamic get episode {
    _$episodeAtom.reportRead();
    return super.episode;
  }

  @override
  set episode(dynamic value) {
    _$episodeAtom.reportWrite(value, super.episode, () {
      super.episode = value;
    });
  }

  late final _$hasEpisodeAtom =
      Atom(name: 'DetailControllerBase.hasEpisode', context: context);

  @override
  bool get hasEpisode {
    _$hasEpisodeAtom.reportRead();
    return super.hasEpisode;
  }

  @override
  set hasEpisode(bool value) {
    _$hasEpisodeAtom.reportWrite(value, super.hasEpisode, () {
      super.hasEpisode = value;
    });
  }

  late final _$charactersAtom =
      Atom(name: 'DetailControllerBase.characters', context: context);

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
      Atom(name: 'DetailControllerBase.hasCharacters', context: context);

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

  late final _$getEpisodeAsyncAction =
      AsyncAction('DetailControllerBase.getEpisode', context: context);

  @override
  Future getEpisode(String id) {
    return _$getEpisodeAsyncAction.run(() => super.getEpisode(id));
  }

  late final _$getListOfCharactersAsyncAction =
      AsyncAction('DetailControllerBase.getListOfCharacters', context: context);

  @override
  Future getListOfCharacters(List<int> ids) {
    return _$getListOfCharactersAsyncAction
        .run(() => super.getListOfCharacters(ids));
  }

  @override
  String toString() {
    return '''
episode: ${episode},
hasEpisode: ${hasEpisode},
characters: ${characters},
hasCharacters: ${hasCharacters}
    ''';
  }
}
