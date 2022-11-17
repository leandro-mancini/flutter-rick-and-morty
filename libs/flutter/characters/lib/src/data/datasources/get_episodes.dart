import '../models/episode_model.dart';

abstract class IGetEpisodesDataSource {
  Future<List<EpisodeModel>> getListOfEpisodes(List<int> ids);
}