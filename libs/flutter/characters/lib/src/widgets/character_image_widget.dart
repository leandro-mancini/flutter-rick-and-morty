import 'package:flutter/material.dart';

class CharacterImageWidget extends StatelessWidget {
  const CharacterImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          margin: const EdgeInsets.all(24),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://observatoriodocinema.uol.com.br/wp-content/uploads/2022/09/Rick-and-Morty-17052022-1200x900-1.jpg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        )
      ],
    );
  }
}