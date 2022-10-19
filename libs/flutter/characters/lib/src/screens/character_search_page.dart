import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/widgets/feedback_page_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

var characterService = CharacterService();

class CharacterSearchPage extends StatefulWidget {
  final String searchText;

  const CharacterSearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  State<CharacterSearchPage> createState() => _CharacterSearchPageState();
}

class _CharacterSearchPageState extends State<CharacterSearchPage> {
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchValueController.text = widget.searchText;

    print(searchValueController.text);

    super.initState();
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
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.black87,
        ),
        onPressed: () => Modular.to.pop(),
      ),
      centerTitle: true,
      title: const Text('Busca', style: TextStyle(color: Colors.black87, fontSize: 16),),
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
              setState(() {
                searchValueController.text = value;
              });
            },
            textInputAction: TextInputAction.go,
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return FutureBuilder<List<Character>>(
      future: characterService.getFilteredCharacters(CharacterFilters(
        name: searchValueController.text
      )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const FeedbackPageWidget(
            illustration: 'assets/illustrations/search.svg',
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
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