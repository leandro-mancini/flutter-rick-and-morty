import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_episodes/src/domain/entities/character_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_episodes/src/domain/repositories/character_repository.dart';

import '../datasources/character_datasource.dart';
import '../models/character_model.dart';

class CharacterRepository implements ICharacterRepository {
  final ICharacterDataSource dataSource;

  CharacterRepository(this.dataSource);

  @override
  Future<Either<Failure, List<CharacterEntity>>> getListOfCharacters(List<int> ids) async {
    List<CharacterModel> list;

    try {
      list = await dataSource.getListOfCharacters(ids);
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return list == null ? left(DataError()) : right(list);
  }

}