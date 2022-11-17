import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../repositories/get_favorites.dart';

class GetAllFavoritesUseCase implements UseCase<List<CharacterEntity>> {
  final IGetFavoritesRepository repository;

  GetAllFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CharacterEntity>>> call() async {
    var result = await repository.getAllFavorites();

    return result.fold((l) => left(l), (r) => right(r));
  }

}