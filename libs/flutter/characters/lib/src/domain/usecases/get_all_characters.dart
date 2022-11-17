import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/character_entity.dart';
import '../repositories/get_characters.dart';

class GetAllCharactersUseCase implements UseCase<List<CharacterEntity>> {
  final IGetCharactersRepository repository;

  GetAllCharactersUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<CharacterEntity>>> call() async {
    var result = await repository.getAllCharacters();

    return  result.fold((l) => left(l), (r) => right(r));
  }

}