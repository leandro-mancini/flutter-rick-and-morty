import '../models/episode_model.dart';

abstract class IEpisodeDataSource {
  Future<EpisodeModel> getEpisode(String id);
}