import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'detail_controller.g.dart';

var characterService = CharacterService();
var episodeService = EpisodeService();

class DetailController = DetailControllerBase with _$DetailController;

abstract class DetailControllerBase with Store {
  @observable
  dynamic character;

  @observable
  bool hasCharacter = false;

  @observable
  List<Episode> episodes = <Episode>[];

  @observable
  bool hasEpisodes = false;

  @action
  getCharacter(String id) async {
    character = await characterService.getCharacter(id);

    hasCharacter = true;

    return character;
  }

  @action
  getListOfEpisodes(List<int> ids) async {
    episodes = await episodeService.getListOfEpisodes(ids);

    hasEpisodes = true;
  }
}