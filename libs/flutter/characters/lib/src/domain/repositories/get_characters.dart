import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/character_entity.dart';

abstract class IGetCharactersRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters();
  Future<Either<Failure, List<CharacterEntity>>> getFilteredCharacters(CharacterFilters filters);
  Future<Either<Failure, CharacterEntity>> getCharacter(String id);
}