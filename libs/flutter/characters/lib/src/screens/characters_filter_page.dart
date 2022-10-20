import 'package:flutter/material.dart';
import 'package:flutter_characters/src/widgets/choice_chip_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CharactersFilterPage extends StatefulWidget {
  const CharactersFilterPage({Key? key}) : super(key: key);

  @override
  State<CharactersFilterPage> createState() => _CharactersFilterPageState();
}

class _CharactersFilterPageState extends State<CharactersFilterPage> {
  String valueStatus = '';
  String valueSpecie = '';
  String valueGender = '';

  List<String> optionsStatus = ['alive', 'dead', 'unknown'];
  List<String> optionsSpecies = ['alien', 'human', 'unknown'];
  List<String> optionsGender = ['female', 'male', 'genderless', 'unknown'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAppBar(),
        buildFilterOptions(
          title: 'Status',
          options: optionsStatus,
          onChange: (value) => print(optionsStatus[value])
        ),
        buildFilterOptions(
          title: 'Espécies',
          options: optionsSpecies,
          onChange: (value) => print(optionsSpecies[value])
        ),
        buildFilterOptions(
          title: 'Gênero',
          options: optionsGender,
          onChange: (value) => print(optionsGender[value])
        ),
        const SizedBox(height:16),
        buildAction(),
      ],
    );
  }

  Widget buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text('Filtrar', style: TextStyle(color: Colors.black87, fontSize: 18),),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black87,
          ),
          onPressed: () => Modular.to.pop(),
        ),
      ],
    );
  }

  Widget buildFilterOptions({
    required String title,
    required List<String> options,
    required Function(dynamic) onChange
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ChoiceChipWidget(options: options, onChange: (value) => onChange(value)),
        ),
      ],
    );
  }

  Widget buildAction() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          primary: Colors.red,
          onPrimary: Colors.white,
        ),
        child: const Text('APLICAR'),
      ),
    );
  }
}