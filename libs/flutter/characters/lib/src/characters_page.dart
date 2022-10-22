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
      appBar: buildAppBar(),
      body: SafeArea(
        child: buildList(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text('Personagens', style: TextStyle(color: Colors.black87, fontSize: 16),),
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
      bottom: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: 42,
          child: TextField(
            controller: searchValueController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none
              ),
              hintText: 'Buscar personagens',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: 18,
                child: const Icon(Icons.search),
              )
            ),
            onSubmitted: (value) {
              Modular.to.pushNamed('/character/search/$value');
              searchValueController.clear();
            },
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return Observer(
      builder: (_) {
        if (charactersController.characters.isEmpty && charactersController.hasCharacters) {
          return const FeedbackPageWidget(
            illustration: 'assets/illustrations/search.svg',
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }

        return charactersController.hasCharacters ? ListView.builder(
          itemCount: charactersController.characters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(charactersController.characters[index].image),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(charactersController.characters[index].name),
              subtitle: Text(charactersController.characters[index].species),
              onTap: () => Modular.to.pushNamed('/character/${charactersController.characters[index].id}'),
            );
          },
        ) : const Center(child: CircularProgressIndicator(),);
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