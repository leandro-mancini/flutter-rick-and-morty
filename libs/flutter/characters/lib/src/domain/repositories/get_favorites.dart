import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';


abstract class IGetFavoritesRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllFavorites();
  void setFavorite(CharacterEntity character);
  void deleteFavorite(CharacterEntity character);
}