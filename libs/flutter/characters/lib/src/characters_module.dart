import 'package:flutter_characters/src/data/repositories/get_episodes.dart';
import 'package:flutter_characters/src/data/repositories/get_favorites.dart';
import 'package:flutter_characters/src/domain/usecases/delete_favorite.dart';
import 'package:flutter_characters/src/domain/usecases/get_character.dart';
import 'package:flutter_characters/src/domain/usecases/get_filtered_characters.dart';
import 'package:flutter_commons/flutter_commons.dart';

import 'data/external/characters.dart';
import 'data/external/episodes.dart';
import 'data/local/favorites.dart';
import 'data/repositories/get_characters.dart';
import 'domain/usecases/get_all_characters.dart';
import 'domain/usecases/get_all_favorite.dart';
import 'domain/usecases/get_character_episodes.dart';
import 'domain/usecases/post_favorite.dart';
import 'presenter/pages/detail/detail_controller.dart';
import 'presenter/pages/detail/detail_page.dart';
import 'presenter/pages/favorites/favorites_controller.dart';
import 'presenter/pages/favorites/favorites_page.dart';
import 'presenter/pages/list/list_controller.dart';
import 'presenter/pages/list/list_page.dart';
import 'presenter/pages/search/search_controller.dart';
import 'presenter/pages/search/search_page.dart';

class CharactersModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => SharedPref()),
    Bind((i) => DioService()),
    Bind((i) => GetCharactersDataSource(i())),
    Bind((i) => GetEpisodesDataSource(i())),
    Bind((i) => FavoritesDataSource(i())),
    Bind((i) => GetCharactersRepository(i())),
    Bind((i) => GetEpisodesRepository(i())),
    Bind((i) => GetFavoritesRepository(i())),
    Bind((i) => GetAllCharactersUseCase(i())),
    Bind((i) => GetFilteredCharactersUseCase(i())),
    Bind((i) => GetCharacterUseCase(i())),
    Bind((i) => GetCharacterEpisodesUseCase(i())),
    Bind((i) => GetAllFavoritesUseCase(i())),
    Bind((i) => PostFavorite(i())),
    Bind((i) => DeleteFavorite(i())),
    Bind((i) => ListController(i(), i())),
    Bind((i) => SearchController(i())),
    Bind((i) => FavoritesController(i())),
    Bind((i) => DetailController(i(), i(), i(), i(), i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => const ListPage()),
    ChildRoute('/character/search/:searchText', child: (context, args) => SearchPage(
      searchText: args.params['searchText'],
    )),
    ChildRoute('/favorites', child: (context, args) => const FavoritesPage()),
    ChildRoute('/character/:id', child: (context, args) => DetailPage(
      id: args.params['id'],
    )),
  ];
}
