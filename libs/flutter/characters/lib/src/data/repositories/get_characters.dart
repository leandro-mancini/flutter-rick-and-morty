import 'package:flutter_characters/src/data/models/character_model.dart';
import 'package:flutter_characters/src/domain/entities/character_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_characters/src/domain/repositories/get_characters.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../datasources/get_characters.dart';

class GetCharactersRepository implements IGetCharactersRepository {
  final IGetCharactersDataSource dataSource;

  GetCharactersRepository(this.dataSource);

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters() async {
    List<CharacterModel> list;

    try {
      list = await dataSource.getAllCharacters();
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return list == null ? left(DataError()) : right(list);
  }
  
  @override
  Future<Either<Failure, List<CharacterEntity>>> getFilteredCharacters(CharacterFilters filters) async {
    List<CharacterModel> list;

    try {
      list = await dataSource.getFilteredCharacters(filters);
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return list == null ? left(DataError()) : right(list);
  }
  
  @override
  Future<Either<Failure, CharacterEntity>> getCharacter(String id) async {
    CharacterModel character;

    try {
      character = await dataSource.getCharacter(id);
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return character == null ? left(DataError()) : right(character);
  }

}