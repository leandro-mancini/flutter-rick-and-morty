import 'package:flutter_commons/flutter_commons.dart';

import '../datasources/character_datasource.dart';
import '../models/character_model.dart';

class CharacterDataSource implements ICharacterDataSource {
  final DioService service;

  CharacterDataSource(this.service);

  @override
  Future<List<CharacterModel>> getListOfCharacters(List<int> ids) async {
    var response = await service.getMethod('${Constants.baseURL}${Constants.characterEndpoint}/$ids');

    if (response.statusCode == 200) {
      List result = response.data as List;

      return result.map((item) => CharacterModel.fromJson(item)).toList();
    } else {
      throw DataError();
    }
  }

}