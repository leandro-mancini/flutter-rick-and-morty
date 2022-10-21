import 'package:flutter_characters/src/characters_page.dart';
import 'package:flutter_characters/src/pages/detail/detail_page.dart';
import 'package:flutter_characters/src/pages/search/search_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const CharactersPage()),
    ChildRoute('/character/:id', child: (context, args) => DetailPage(
      id: args.params['id'],
    )),
    ChildRoute('/character/search/:searchText', child: (context, args) => SearchPage(
      searchText: args.params['searchText'],
    )),
  ];
}