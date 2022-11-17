// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailController on DetailControllerBase, Store {
  late final _$characterAtom =
      Atom(name: 'DetailControllerBase.character', context: context);

  @override
  dynamic get character {
    _$characterAtom.reportRead();
    return super.character;
  }

  @override
  set character(dynamic value) {
    _$characterAtom.reportWrite(value, super.character, () {
      super.character = value;
    });
  }

  late final _$hasCharacterAtom =
      Atom(name: 'DetailControllerBase.hasCharacter', context: context);

  @override
  bool get hasCharacter {
    _$hasCharacterAtom.reportRead();
    return super.hasCharacter;
  }

  @override
  set hasCharacter(bool value) {
    _$hasCharacterAtom.reportWrite(value, super.hasCharacter, () {
      super.hasCharacter = value;
    });
  }

  late final _$episodesAtom =
      Atom(name: 'DetailControllerBase.episodes', context: context);

  @override
  List<EpisodeEntity> get episodes {
    _$episodesAtom.reportRead();
    return super.episodes;
  }

  @override
  set episodes(List<EpisodeEntity> value) {
    _$episodesAtom.reportWrite(value, super.episodes, () {
      super.episodes = value;
    });
  }

  late final _$hasEpisodesAtom =
      Atom(name: 'DetailControllerBase.hasEpisodes', context: context);

  @override
  bool get hasEpisodes {
    _$hasEpisodesAtom.reportRead();
    return super.hasEpisodes;
  }

  @override
  set hasEpisodes(bool value) {
    _$hasEpisodesAtom.reportWrite(value, super.hasEpisodes, () {
      super.hasEpisodes = value;
    });
  }

  late final _$favoritesAtom =
      Atom(name: 'DetailControllerBase.favorites', context: context);

  @override
  List<CharacterEntity> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(List<CharacterEntity> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$hasFavoriteAtom =
      Atom(name: 'DetailControllerBase.hasFavorite', context: context);

  @override
  bool get hasFavorite {
    _$hasFavoriteAtom.reportRead();
    return super.hasFavorite;
  }

  @override
  set hasFavorite(bool value) {
    _$hasFavoriteAtom.reportWrite(value, super.hasFavorite, () {
      super.hasFavorite = value;
    });
  }

  late final _$getCharacterAsyncAction =
      AsyncAction('DetailControllerBase.getCharacter', context: context);

  @override
  Future getCharacter(String id) {
    return _$getCharacterAsyncAction.run(() => super.getCharacter(id));
  }

  late final _$getListOfEpisodesAsyncAction =
      AsyncAction('DetailControllerBase.getListOfEpisodes', context: context);

  @override
  Future getListOfEpisodes(List<int> ids) {
    return _$getListOfEpisodesAsyncAction
        .run(() => super.getListOfEpisodes(ids));
  }

  late final _$getAllFavoritesAsyncAction =
      AsyncAction('DetailControllerBase.getAllFavorites', context: context);

  @override
  Future getAllFavorites() {
    return _$getAllFavoritesAsyncAction.run(() => super.getAllFavorites());
  }

  late final _$addCharacterToFavoriteAsyncAction = AsyncAction(
      'DetailControllerBase.addCharacterToFavorite',
      context: context);

  @override
  Future addCharacterToFavorite(CharacterEntity character, bool isFavorite) {
    return _$addCharacterToFavoriteAsyncAction
        .run(() => super.addCharacterToFavorite(character, isFavorite));
  }

  late final _$checkIsFavoriteAsyncAction =
      AsyncAction('DetailControllerBase.checkIsFavorite', context: context);

  @override
  Future checkIsFavorite(CharacterEntity character) {
    return _$checkIsFavoriteAsyncAction
        .run(() => super.checkIsFavorite(character));
  }

  @override
  String toString() {
    return '''
character: ${character},
hasCharacter: ${hasCharacter},
episodes: ${episodes},
hasEpisodes: ${hasEpisodes},
favorites: ${favorites},
hasFavorite: ${hasFavorite}
    ''';
  }
}
