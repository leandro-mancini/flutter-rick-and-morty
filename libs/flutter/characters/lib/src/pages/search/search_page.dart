import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/search/search_controller.dart';
import 'package:flutter_characters/src/widgets/feedback_page_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  final String searchText;

  const SearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = SearchController();
  final searchValueController = TextEditingController();

  @override
  void dispose() {
    searchValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    searchValueController.text = widget.searchText;
    searchController.getFilteredCharacters(widget.searchText);
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
            onSubmitted: (value) => searchController.getFilteredCharacters(value),
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
    );
  }

  Widget buildList() {
    return Observer(
      builder: (_) {
        if (searchController.characters.isEmpty && searchController.hasCharacters) {
          return const FeedbackPageWidget(
            illustration: 'assets/illustrations/search.svg',
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }

        return searchController.hasCharacters ? ListView.builder(
          itemCount: searchController.characters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(searchController.characters[index].image),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(searchController.characters[index].name),
              subtitle: Text(searchController.characters[index].species),
              onTap: () => Modular.to.pushNamed('/character/${searchController.characters[index].id}'),
            );
          },
        ) : const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}