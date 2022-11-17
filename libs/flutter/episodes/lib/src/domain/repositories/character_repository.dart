import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/character_entity.dart';

abstract class ICharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getListOfCharacters(List<int> ids);
}