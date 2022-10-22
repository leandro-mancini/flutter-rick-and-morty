// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EpisodesController on EpisodesControllerBase, Store {
  late final _$episodeAtom =
      Atom(name: 'EpisodesControllerBase.episode', context: context);

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
      Atom(name: 'EpisodesControllerBase.hasEpisode', context: context);

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
      Atom(name: 'EpisodesControllerBase.characters', context: context);

  @override
  List<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$hasCharactersAtom =
      Atom(name: 'EpisodesControllerBase.hasCharacters', context: context);

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
      AsyncAction('EpisodesControllerBase.getEpisode', context: context);

  @override
  Future getEpisode(String id) {
    return _$getEpisodeAsyncAction.run(() => super.getEpisode(id));
  }

  late final _$getListOfCharactersAsyncAction = AsyncAction(
      'EpisodesControllerBase.getListOfCharacters',
      context: context);

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
