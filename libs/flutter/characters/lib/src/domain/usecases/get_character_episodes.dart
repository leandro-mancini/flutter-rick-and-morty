import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../entities/episode_entity.dart';
import '../repositories/get_episodes.dart';

abstract class IGetCharacterEpisodesUseCase {
  Future<Either<Failure, List<EpisodeEntity>>> call(List<int> ids);
}

class GetCharacterEpisodesUseCase implements IGetCharacterEpisodesUseCase {
  final IGetEpisodesRepository repository;

  GetCharacterEpisodesUseCase(this.repository);

  @override
  Future<Either<Failure, List<EpisodeEntity>>> call(List<int> ids) async {
    var result = await repository.getListOfEpisodes(ids);

    return result.fold((l) => left(l), (r) => right(r));
  }

}