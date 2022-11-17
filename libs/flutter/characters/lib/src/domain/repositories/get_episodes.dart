import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/episode_entity.dart';

abstract class IGetEpisodesRepository {
  Future<Either<Failure, List<EpisodeEntity>>> getListOfEpisodes(List<int> ids);
}