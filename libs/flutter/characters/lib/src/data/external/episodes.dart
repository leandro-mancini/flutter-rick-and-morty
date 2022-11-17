import 'package:flutter_characters/src/data/models/episode_model.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../datasources/get_episodes.dart';

class GetEpisodesDataSource implements IGetEpisodesDataSource {
  final DioService service;

  GetEpisodesDataSource(this.service);
  
  @override
  Future<List<EpisodeModel>> getListOfEpisodes(List<int> ids) async {
    var response = await service.getMethod('${Constants.baseURL}${Constants.episodeEndpoint}/$ids');

    if (response.statusCode == 200) {
      List result = response.data as List;

      return result.map((item) => EpisodeModel.fromJson(item)).toList();
    } else {
      throw DataError();
    }
  }

}