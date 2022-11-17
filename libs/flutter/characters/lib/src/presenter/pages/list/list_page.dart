import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shared/flutter_shared.dart';

import '../../widgets/filters_widget.dart';
import '../../widgets/list_characters_widget.dart';
import 'list_controller.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final controller = Modular.get<ListController>();
  final searchValueController = TextEditingController();

  @override
  void initState() {
    controller.getAllCharacters();
    
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
      title: 'Personagens',
      searchHintText: 'Buscar personagens',
      searchController: searchValueController,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        Modular.to.pushNamed('/characters/character/search/$value')
          .then((value) => controller.getAllCharacters());
        searchValueController.clear();
      },
      onChanged: ((value) => controller.getFilteredToCharacter(value)),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.bookmark_added,
            color: Colors.red,
          ),
          onPressed: () => Modular.to.pushNamed('/characters/favorites'),
        ),
        IconButton(
          icon: const Icon(
            Icons.filter_list_outlined,
            color: Colors.red,
          ),
          onPressed: () => changeFilter(),
        )
      ],
    );
  }

  Widget _buildList() {
    return Observer(
      builder: (_) {
        if (controller.characters.isEmpty && controller.hasCharacters) {
          return SingleChildScrollView(
            child: FeedbackPageWidget(
              illustration: Assets.ilSearch,
              message: 'Desculpe, não conseguimos \n encontrar o personagem',
              description: 'Não se preocupe, ainda podemos \nbuscar no banco de dados.',
              enabledAction: true,
              textButton: 'Buscar',
              onPressed: () {
                Modular.to.pushNamed('/characters/character/search/${searchValueController.text}')
                  .then((value) => controller.getAllCharacters());
                searchValueController.clear();
              },
            ),
          );
        }

        return ListCharactersWidget(
          characters: controller.characters,
          isLoading: controller.hasCharacters,
          itemCount: controller.characters.length,
          onTap: (int index) => Modular.to.pushNamed('/characters/character/${controller.characters[index].id}'),
        );
      }
    );
  }

  void changeFilter() {
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: FiltersWidget(
            onChange: (CharacterFilters filters) {
              controller.getFilteredCharacters(filters);
            },
          ),
        );
      }
    );
  }
}