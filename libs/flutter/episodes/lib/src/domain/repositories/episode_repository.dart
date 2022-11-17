import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/episode_entity.dart';

abstract class IEpisodeRepository {
  Future<Either<Failure, EpisodeEntity>> getEpisode(String id);
}