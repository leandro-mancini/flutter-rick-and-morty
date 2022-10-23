import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';
import 'package:flutter_characters/src/models/filter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';

class FiltersWidget extends StatefulWidget {
  final Function(CharacterFilters) onChange;

  const FiltersWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  CharacterStatus valueStatus = CharacterStatus.empty;

  CharacterSpecies valueSpecie = CharacterSpecies.empty;

  CharacterGender valueGender = CharacterGender.empty;

  List<Filter> optionsStatus = [
    Filter(label: 'Todos', value: CharacterStatus.empty),
    Filter(label: 'Alive', value: CharacterStatus.alive),
    Filter(label: 'Dead', value: CharacterStatus.dead),
    Filter(label: 'unknown', value: CharacterStatus.unknown),
  ];
  
  List<Filter> optionsSpecies = [
    Filter(label: 'Todos', value: CharacterSpecies.empty),
    Filter(label: 'Alien', value: CharacterSpecies.alien),
    Filter(label: 'Human', value: CharacterSpecies.human),
    Filter(label: 'unknown', value: CharacterSpecies.unknown),
  ];

  List<Filter> optionsGender = [
    Filter(label: 'Todos', value: CharacterGender.empty),
    Filter(label: 'Female', value: CharacterGender.female),
    Filter(label: 'Male', value: CharacterGender.male),
    Filter(label: 'Genderless', value: CharacterGender.genderless),
    Filter(label: 'unknown', value: CharacterGender.unknown),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildFilters(),
          buildAction(),
        ],
      ),
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

  Widget buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildAppBar(),
        buildFilterOptions(
          title: 'Status',
          options: optionsStatus,
          selectedIndex: 0,
          onChange: (value) => valueStatus = optionsStatus[value].value
        ),
        buildFilterOptions(
          title: 'Espécies',
          options: optionsSpecies,
          selectedIndex: 0,
          onChange: (value) => valueSpecie = optionsSpecies[value].value
        ),
        buildFilterOptions(
          title: 'Gênero',
          options: optionsGender,
          selectedIndex: 0,
          onChange: (value) => valueGender = optionsGender[value].value
        ),
      ],
    );
  }

  Widget buildFilterOptions({
    dynamic selectedIndex,
    required String title,
    required List<Filter> options,
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
          child: ChoiceChipWidget(options: options, selectedIndex: selectedIndex, onChange: (value) => onChange(value)),
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
        onPressed: () {
          widget.onChange(CharacterFilters(
            status: valueStatus,
            gender: valueGender,
            species: valueSpecie
          ));

          Modular.to.pop();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Text('APLICAR'),
      ),
    );
  }
}