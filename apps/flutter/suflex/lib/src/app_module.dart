import 'package:flutter_characters/flutter_characters.dart';
import 'package:flutter_episodes/flutter_episodes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/', module: CharactersModule()),
    ModuleRoute('/episode', module: EpisodesModule())
  ];
}