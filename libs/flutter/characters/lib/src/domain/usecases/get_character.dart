import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../repositories/get_characters.dart';

abstract class IGetCharacterUseCase {
  Future<Either<Failure, CharacterEntity>> call(String id);
}

class GetCharacterUseCase implements IGetCharacterUseCase {
  final IGetCharactersRepository repository;

  GetCharacterUseCase(this.repository);
  
  @override
  Future<Either<Failure, CharacterEntity>> call(String id) async {
    var result = await repository.getCharacter(id);

    return result.fold((l) => left(l), (r) => right(r));
  }}