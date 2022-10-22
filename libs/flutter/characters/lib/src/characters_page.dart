import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/characters_controller.dart';
import 'package:flutter_characters/src/widgets/filters_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final charactersController = CharactersController();
  final searchValueController = TextEditingController();

  @override
  void initState() {
    charactersController.getAllCharacters();
    
    super.initState();
  }

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Personagens',
        searchHintText: 'Buscar personagens',
        searchController: searchValueController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          Modular.to.pushNamed('/character/search/$value')
            .then((value) => charactersController.getAllCharacters());
          searchValueController.clear();
        },
        onChanged: ((value) => charactersController.getFilteredToCharacter(value)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_added,
              color: Colors.red,
            ),
            onPressed: () => Modular.to.pushNamed('/favorites'),
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list_outlined,
              color: Colors.red,
            ),
            onPressed: () => changeFilter(),
          )
        ],
      ),
      body: SafeArea(
        child: buildList(),
      ),
    );
  }

  Widget buildList() {
    return Observer(
      builder: (_) {
        if (charactersController.characters.isEmpty && charactersController.hasCharacters) {
          return SingleChildScrollView(
            child: FeedbackPageWidget(
              illustration: Assets.ilSearch,
              message: 'Desculpe, não conseguimos \n encontrar o personagem',
              description: 'Não se preocupe, ainda podemos \nbuscar no banco de dados.',
              enabledAction: true,
              textButton: 'Buscar',
              onPressed: () {
                Modular.to.pushNamed('/character/search/${searchValueController.text}')
                  .then((value) => charactersController.getAllCharacters());
                searchValueController.clear();
              },
            ),
          );
        }

        return SkeletonListWidget(
          itemCount: 10,
          isLoading: !charactersController.hasCharacters,
          child: ListView.builder(
            itemCount: charactersController.characters.length,
            itemBuilder: (context, index) {
              return ListTileWidget(
                title: charactersController.characters[index].name,
                subtitle: charactersController.characters[index].species,
                backgroundImage: NetworkImage(charactersController.characters[index].image),
                onTap: () => Modular.to.pushNamed('/character/${charactersController.characters[index].id}'),
              );
            },
          ),
        );
      },
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
              charactersController.getFilteredCharacters(filters);
            },
          ),
        );
      }
    );
  }
}