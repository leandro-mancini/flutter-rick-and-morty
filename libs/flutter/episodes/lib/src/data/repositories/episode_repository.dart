import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_episodes/src/data/datasources/episode_datasource.dart';
import 'package:flutter_episodes/src/data/models/episode_model.dart';
import 'package:flutter_episodes/src/domain/entities/episode_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_episodes/src/domain/repositories/episode_repository.dart';

class EpisodeRepository implements IEpisodeRepository {
  final IEpisodeDataSource dataSource;

  EpisodeRepository(this.dataSource);

  @override
  Future<Either<Failure, EpisodeEntity>> getEpisode(String id) async {
    EpisodeModel episode;

    try {
      episode = await dataSource.getEpisode(id);
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return episode == null ? left(DataError()) : right(episode);
  }

}