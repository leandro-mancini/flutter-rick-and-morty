import 'package:flutter_characters/src/characters_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Characters extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const CharactersPage())
  ];
}