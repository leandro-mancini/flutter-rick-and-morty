import 'package:flutter/material.dart';
import 'package:flutter_characters/src/widgets/appbar_widget.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          AppBarWidget()
        ],
      ),
    );
  }
}