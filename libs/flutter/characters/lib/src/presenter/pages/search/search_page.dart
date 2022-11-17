import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shared/flutter_shared.dart';

import '../../widgets/list_characters_widget.dart';
import 'search_controller.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = Modular.get<SearchController>();
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchValueController.text = widget.searchText;
    controller.getFilteredCharacters(widget.searchText);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildList(),
    );
  }

  AppBarWidget _buildAppBar() {
    return AppBarWidget(
      title: 'Busca',
      centerTitle: true,
      searchHintText: 'Buscar personagens',
      searchController: searchValueController,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => controller.getFilteredCharacters(value),
      onPressedLeadingIcon: () => Modular.to.pop(),
      onChanged: ((value) => controller.getFilteredToSearchCharacter(value)),
    );
  }

  Widget _buildList() {
    return Observer(
      builder: (_) {
        if (controller.characters.isEmpty && controller.hasCharacters) {
          return const FeedbackPageWidget(
            illustration: Assets.ilSearch,
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }

        return ListCharactersWidget(
          characters: controller.characters,
          isLoading: controller.hasCharacters,
          itemCount: controller.characters.length,
          onTap: (int index) => Modular.to.pushNamed('/characters/character/${controller.characters[index].id}'),
        );
      },
    );
  }
}