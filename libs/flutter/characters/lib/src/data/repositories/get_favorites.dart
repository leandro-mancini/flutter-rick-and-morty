import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/repositories/get_favorites.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../datasources/get_favorites.dart';
import '../models/character_model.dart';

class GetFavoritesRepository implements IGetFavoritesRepository {
  final IGetFavoritesDataSource dataSource;

  GetFavoritesRepository(this.dataSource);

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllFavorites() async {
    List<CharacterModel> list;

    try {
      list = await dataSource.getAllFavorites();
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return list == null ? left(DataError()) : right(list);
  }
  
  @override
  void setFavorite(CharacterEntity character) async {
    var model = CharacterModel.fromJson(character.toJson());

    dataSource.setFavorite(model);
  }
  
  @override
  void deleteFavorite(CharacterEntity character) {
    var model = CharacterModel.fromJson(character.toJson());

    dataSource.deleteFavorite(model);
  }

}