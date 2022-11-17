import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_episodes/src/data/datasources/episode_datasource.dart';

import '../models/episode_model.dart';

class EpisodeDataSource implements IEpisodeDataSource {
  final DioService service;

  EpisodeDataSource(this.service);
  
  @override
  Future<EpisodeModel> getEpisode(String id) async {
    var response = await service.getMethod('${Constants.baseURL}${Constants.episodeEndpoint}/$id');

    if (response.statusCode == 200) {
      var result = response.data;

      return EpisodeModel.fromJson(result);
    } else {
      throw DataError();
    }
  }

}