import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/favorites/favorites_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final favoriteController = FavoriteController();
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    favoriteController.getFavorites();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Favoritos',
        centerTitle: true,
        searchHintText: 'Buscar personagens',
        searchController: searchValueController,
        textInputAction: TextInputAction.search,
        onChanged: ((value) => favoriteController.getFilteredToFavorite(value)),
        onSubmitted: (value) => favoriteController.getFilteredToFavorite(value),
        onPressedLeadingIcon: () => Modular.to.pop(),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Observer(
      builder: (_) {
        if (favoriteController.favorites.isEmpty &&
          favoriteController.hasFavorites &&
          favoriteController.hasFilterFavorites
        ) {
          return const FeedbackPageWidget(
            illustration: Assets.ilSearch,
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }
        
        if (favoriteController.favorites.isEmpty && favoriteController.hasFavorites) {
          return const FeedbackPageWidget(
            illustration: Assets.ilFavorite,
            message: 'Ops! você ainda não \nadicionou nenhum favorito',
          );
        }

        return SkeletonListWidget(
          itemCount: 10,
          isLoading: !favoriteController.hasFavorites,
          child: ListView.builder(
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              return ListTileWidget(
                title: favoriteController.favorites[index].name,
                subtitle: favoriteController.favorites[index].species,
                backgroundImage: NetworkImage(favoriteController.favorites[index].image),
                onTap: () {
                  Modular.to.pushNamed('/characters/character/${favoriteController.favorites[index].id}')
                    .then((value) => favoriteController.getFavorites());

                  searchValueController.clear();
                },
              );
            },
          )
        );
      },
    );
  }
}