import 'package:flutter_commons/flutter_commons.dart';

import '../datasources/get_characters.dart';
import '../models/character_model.dart';

class GetCharactersDataSource implements IGetCharactersDataSource {
  final DioService service;

  GetCharactersDataSource(this.service);

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    var response = await service.getMethod('${Constants.baseURL}${Constants.characterEndpoint}');

    if (response.statusCode == 200) {
      List result = response.data['results'] as List;

      return result.map((item) => CharacterModel.fromJson(item)).toList();
    } else {
      throw DataError();
    }
  }
  
  @override
  Future<List<CharacterModel>> getFilteredCharacters(CharacterFilters filters) async {
    var prefs =
      '?name=${filters.name}&status=${characterStatusValues[filters.status]}&gender=${characterGenderValues[filters.gender]}&type=${filters.type}&species=${characterSpeciesValues[filters.species]}';

    var response = await service.getMethod('${Constants.baseURL}${Constants.characterEndpoint}$prefs');

    if (response.statusCode == 200) {
      List result = response.data['results'] as List;

      return result.map((item) => CharacterModel.fromJson(item)).toList();
    } else {
      throw DataError();
    }
  }
  
  @override
  Future<CharacterModel> getCharacter(String id) async {
    var response = await service.getMethod('${Constants.baseURL}${Constants.characterEndpoint}/$id');

    if (response.statusCode == 200) {
      var result = response.data;

      return CharacterModel.fromJson(result);
    } else {
      throw DataError();
    }
  }
}