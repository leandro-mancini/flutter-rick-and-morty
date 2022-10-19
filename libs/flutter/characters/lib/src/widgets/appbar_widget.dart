import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
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
      bottom: buildAppBar()
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: SizedBox(
        height: 42,
        child: TextField(
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
        ),
      ),
    );
  }
}