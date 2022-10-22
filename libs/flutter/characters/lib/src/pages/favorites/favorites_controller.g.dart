// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteController on FavoriteControllerBase, Store {
  late final _$hasFavoritesAtom =
      Atom(name: 'FavoriteControllerBase.hasFavorites', context: context);

  @override
  bool get hasFavorites {
    _$hasFavoritesAtom.reportRead();
    return super.hasFavorites;
  }

  @override
  set hasFavorites(bool value) {
    _$hasFavoritesAtom.reportWrite(value, super.hasFavorites, () {
      super.hasFavorites = value;
    });
  }

  late final _$hasFilterFavoritesAtom =
      Atom(name: 'FavoriteControllerBase.hasFilterFavorites', context: context);

  @override
  bool get hasFilterFavorites {
    _$hasFilterFavoritesAtom.reportRead();
    return super.hasFilterFavorites;
  }

  @override
  set hasFilterFavorites(bool value) {
    _$hasFilterFavoritesAtom.reportWrite(value, super.hasFilterFavorites, () {
      super.hasFilterFavorites = value;
    });
  }

  late final _$allFavoritesAtom =
      Atom(name: 'FavoriteControllerBase.allFavorites', context: context);

  @override
  List<Character> get allFavorites {
    _$allFavoritesAtom.reportRead();
    return super.allFavorites;
  }

  @override
  set allFavorites(List<Character> value) {
    _$allFavoritesAtom.reportWrite(value, super.allFavorites, () {
      super.allFavorites = value;
    });
  }

  late final _$favoritesAtom =
      Atom(name: 'FavoriteControllerBase.favorites', context: context);

  @override
  List<Character> get favorites {
    _$favoritesAtom.reportRead();
    return super.favorites;
  }

  @override
  set favorites(List<Character> value) {
    _$favoritesAtom.reportWrite(value, super.favorites, () {
      super.favorites = value;
    });
  }

  late final _$getFavoritesAsyncAction =
      AsyncAction('FavoriteControllerBase.getFavorites', context: context);

  @override
  Future getFavorites() {
    return _$getFavoritesAsyncAction.run(() => super.getFavorites());
  }

  late final _$getFilteredToFavoriteAsyncAction = AsyncAction(
      'FavoriteControllerBase.getFilteredToFavorite',
      context: context);

  @override
  Future getFilteredToFavorite(String value) {
    return _$getFilteredToFavoriteAsyncAction
        .run(() => super.getFilteredToFavorite(value));
  }

  @override
  String toString() {
    return '''
hasFavorites: ${hasFavorites},
hasFilterFavorites: ${hasFilterFavorites},
allFavorites: ${allFavorites},
favorites: ${favorites}
    ''';
  }
}
