import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/episode_entity.dart';
import '../repositories/episode_repository.dart';

abstract class IGetEpisodeUseCase {
  Future<Either<Failure, EpisodeEntity>> call(String id);
}

class GetEpisodeUseCase implements IGetEpisodeUseCase {
  final IEpisodeRepository repository;

  GetEpisodeUseCase(this.repository);

  @override
  Future<Either<Failure, EpisodeEntity>> call(String id) async {
    var result = await repository.getEpisode(id);

    return result.fold((l) => left(l), (r) => right(r));
  }

}