import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

abstract class IGetCharactersUseCase {
  Future<Either<Failure, List<CharacterEntity>>> call(List<int> ids);
}

class GetCharactersUseCase implements IGetCharactersUseCase {
  final ICharacterRepository repository;

  GetCharactersUseCase(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call(List<int> ids) async {
    var result = await repository.getListOfCharacters(ids);

    return result.fold((l) => left(l), (r) => right(r));
  }

}