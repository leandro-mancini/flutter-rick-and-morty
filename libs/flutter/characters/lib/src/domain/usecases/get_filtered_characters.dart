import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../repositories/get_characters.dart';

abstract class IGetFilteredCharactersUseCase {
  Future<Either<Failure, List<CharacterEntity>>> call(CharacterFilters filters);
}

class GetFilteredCharactersUseCase implements IGetFilteredCharactersUseCase {
  final IGetCharactersRepository repository;

  GetFilteredCharactersUseCase(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(CharacterFilters filters) async {
    var result = await repository.getFilteredCharacters(filters);

    return  result.fold((l) => left(l), (r) => right(r));
  }

}