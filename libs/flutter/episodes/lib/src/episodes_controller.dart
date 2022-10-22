import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'episodes_controller.g.dart';

var episodeService = EpisodeService();
var characterService = CharacterService();

class EpisodesController = EpisodesControllerBase with _$EpisodesController;

abstract class EpisodesControllerBase with Store {
  @observable
  dynamic episode;

  @observable
  bool hasEpisode = false;

  @observable
  List<Character> characters = <Character>[];

  @observable
  bool hasCharacters = false;

  @action
  getEpisode(String id) async {
    episode = await episodeService.getEpisode(id);

    hasEpisode = true;

    return episode;
  }

  @action
  getListOfCharacters(List<int> ids) async {
    characters = await characterService.getListOfCharacters(ids);

    hasCharacters = true;
  }
}