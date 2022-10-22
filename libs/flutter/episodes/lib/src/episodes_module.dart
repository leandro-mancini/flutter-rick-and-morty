import 'package:flutter_episodes/src/episodes_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EpisodesModule extends Module {
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/:id', child: (context, args) => EpisodesPage(id: args.params['id'])),
  ];
}