import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/widgets/feedback_page_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

var characterService = CharacterService();

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final searchValueController = TextEditingController();

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
          onPressed: () => print('Clicou em favoritos'),
        ),
        IconButton(
          icon: const Icon(
            Icons.filter_list_outlined,
            color: Colors.red,
          ),
          onPressed: () => print('Clicou em filtro'),
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
    return FutureBuilder<List<Character>>(
      future: characterService.getAllCharacters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const FeedbackPageWidget(
            illustration: 'assets/illustrations/error.svg',
            message: 'Ops! ocorreu um erro ao carregar os dados. Tente novamente por favor!',
          );
        }

        var characters = snapshot.data!;

        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(characters[index].image),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(characters[index].name),
              subtitle: Text(characters[index].species),
              onTap: () => Modular.to.pushNamed('/character/${characters[index].id}'),
            );
          },
        );
      },
    );
  }
}