import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/favorites/favorites_controller.dart';
import 'package:flutter_characters/src/widgets/feedback_page_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
      appBar: buildAppBar(),
      body: buildBody(),
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
      title: const Text('Favoritos', style: TextStyle(color: Colors.black87, fontSize: 16),),
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
            onChanged: ((value) => favoriteController.getFilteredToFavorite(value)),
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
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
            illustration: 'assets/illustrations/search.svg',
            message: 'Desculpe, não conseguimos \n encontrar o personagem',
          );
        }
        
        if (favoriteController.favorites.isEmpty && favoriteController.hasFavorites) {
          return const FeedbackPageWidget(
            illustration: 'assets/illustrations/favorite.svg',
            message: 'Ops! você ainda não \nadicionou nenhum favorito',
          );
        }

        return favoriteController.hasFavorites ? ListView.builder(
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(favoriteController.favorites[index].image),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(favoriteController.favorites[index].name),
              subtitle: Text(favoriteController.favorites[index].species),
              onTap: () {
                Modular.to.pushNamed('/character/${favoriteController.favorites[index].id}')
                  .then((value) => favoriteController.getFavorites());

                searchValueController.clear();
              },
            );
          },
        ) : const Center(child: CircularProgressIndicator(),);
      },
    );
  }
}