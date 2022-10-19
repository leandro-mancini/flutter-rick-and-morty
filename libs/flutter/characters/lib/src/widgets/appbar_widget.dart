import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      bottom: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_added,
              color: Colors.black87,
            ),
            onPressed: () => print('Clicou em favoritos'),
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list_outlined,
              color: Colors.black87,
            ),
            onPressed: () => print('Clicou em filtro'),
          )
        ],
        title: Row(
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none
                  ),
                  hintText: 'Buscar personagens',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(15),
                    width: 18,
                    child: const Icon(Icons.search),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}