import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_episodes/src/presenter/pages/detail/detail_controller.dart';

import 'data/external/character_datasource.dart';
import 'data/external/episode_datasource.dart';
import 'data/repositories/character_repository.dart';
import 'data/repositories/episode_repository.dart';
import 'domain/usecases/get_characters.dart';
import 'domain/usecases/get_episode.dart';
import 'presenter/pages/detail/detail_page.dart';

class EpisodesModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => DioService()),
    Bind((i) => CharacterDataSource(i())),
    Bind((i) => EpisodeDataSource(i())),
    Bind((i) => CharacterRepository(i())),
    Bind((i) => EpisodeRepository(i())),
    Bind((i) => GetEpisodeUseCase(i())),
    Bind((i) => GetCharactersUseCase(i())),
    Bind((i) => DetailController(i(), i()))
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/:id', child: (context, args) => DetailPage(id: args.params['id'])),
  ];
}