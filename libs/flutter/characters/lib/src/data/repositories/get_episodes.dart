import 'package:flutter_characters/src/domain/entities/episode_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_commons/flutter_commons.dart';

import '../../domain/repositories/get_episodes.dart';
import '../datasources/get_episodes.dart';
import '../models/episode_model.dart';

class GetEpisodesRepository implements IGetEpisodesRepository {
  final IGetEpisodesDataSource dataSource;

  GetEpisodesRepository(this.dataSource);

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getListOfEpisodes(List<int> ids) async {
    List<EpisodeModel> list;

    try {
      list = await dataSource.getListOfEpisodes(ids);
    } catch (e) {
      return left(DataError());
    }

    // ignore: unnecessary_null_comparison
    return list == null ? left(DataError()) : right(list);
  }

}