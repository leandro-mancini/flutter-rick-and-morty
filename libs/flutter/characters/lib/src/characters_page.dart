import 'package:flutter/material.dart';
import 'package:flutter_characters/src/widgets/appbar_widget.dart';
import 'package:flutter_characters/src/widgets/character_all_list_widget.dart';

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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AppBarWidget(),
            SliverPadding(
              padding: EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Personagens',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87
                  ),
                )
              ),
            ),
            CharacterAllListWidget()
          ],
        ),
      ),
    );
  }
}