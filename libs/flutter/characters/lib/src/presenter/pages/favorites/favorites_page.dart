import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shared/flutter_shared.dart';

import '../../widgets/list_characters_widget.dart';
import 'favorites_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final controller = Modular.get<FavoritesController>();
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildList(),
    );
  }

  AppBarWidget _buildAppBar() {
    return AppBarWidget(
      title: 'Favoritos',
      centerTitle: true,
      searchHintText: 'Buscar personagens',
      searchController: searchValueController,
      textInputAction: TextInputAction.search,
      onChanged: ((value) => controller.getFilteredToFavorite(value)),
      onSubmitted: (value) => controller.getFilteredToFavorite(value),
      onPressedLeadingIcon: () => Modular.to.pop(),
    );
  }

  Widget _buildList() {
    return Observer(
      builder: (_) {
        if (controller.favorites.isEmpty &&
          controller.hasFavorites &&
          controller.hasFilterFavorites
        ) {
          return const FeedbackPageWidget(
            illustration: Assets.ilSearch,
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }
        
        if (controller.favorites.isEmpty && controller.hasFavorites) {
          return const FeedbackPageWidget(
            illustration: Assets.ilFavorite,
            message: 'Ops! você ainda não \nadicionou nenhum favorito',
          );
        }

        return ListCharactersWidget(
          characters: controller.favorites,
          isLoading: controller.hasFavorites,
          itemCount: controller.favorites.length,
          onTap: (int index) {
            Modular.to.pushNamed('/characters/character/${controller.favorites[index].id}')
              .then((value) => controller.getFavorites());

            searchValueController.clear();
          },
        );
      },
    );
  }
}