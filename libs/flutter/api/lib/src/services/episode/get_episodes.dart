import '../../constants.dart';
import '../../models/episode.dart';
import '../entities/get_entities.dart';

class EpisodeService extends GetEntitiesService {
  Future<List<Episode>> getListOfEpisodes(List<int> ids) async {
    List<Map<String, dynamic>> objects = await super.getAllEntities(
      '${Constants.baseURL}${Constants.episodeEndpoint}/$ids');

    return List<Episode>.from(objects.map((x) => Episode.fromJson(x)));
  }

  Future<Episode> getEpisode(String id) async {
    dynamic objects = await super
      .getEntitie('${Constants.baseURL}${Constants.episodeEndpoint}/$id');

    return Episode.fromJson(objects);
  }
}