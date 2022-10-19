import 'package:flutter_characters/src/characters_page.dart';
import 'package:flutter_characters/src/screens/character_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const CharactersPage()),
    ChildRoute('/character/:id', child: (context, args) => CharacterDetailPage(id: args.params['id'],))
  ];
}