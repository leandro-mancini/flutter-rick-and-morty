import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EpisodesPage extends StatefulWidget {
  final String id;

  const EpisodesPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(),
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
      title: const Text('Episódio', style: TextStyle(color: Colors.black87, fontSize: 16),),
    );
  }
}