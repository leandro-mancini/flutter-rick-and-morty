import 'package:flutter/material.dart';
import 'package:flutter_characters/src/widgets/character_image_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharacterDetailPage extends StatelessWidget {
  final String id;

  const CharacterDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () => Modular.to.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.black87,
            ),
            onPressed: () => print('Clicou em favoritar'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CharacterImageWidget(),
          ],
        ),
      ),
    );
  }
}