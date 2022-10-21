import 'package:flutter_api/flutter_api.dart';
import 'package:mobx/mobx.dart';
part 'detail_controller.g.dart';

var characterService = CharacterService();

class DetailController = DetailControllerBase with _$DetailController;

abstract class DetailControllerBase with Store {
  @observable
  dynamic character;

  @observable
  bool hasCharacter = false;

  @action
  getCharacter(String id) async {
    character = await characterService.getCharacter(id);

    hasCharacter = true;
  }
}