import 'package:flutter/material.dart';
import 'package:flutter_episodes/src/episodes_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class EpisodesPage extends StatefulWidget {
  final String id;

  const EpisodesPage({Key? key, required this.id}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final episodesController = EpisodesController();

  List<int> getIds(List<String> episode) {
    List<int> ids = episode.map((url) {
      var items = url.split('/');
      var id = items[items.length -1];

      return int.parse(id);
    }).toList();

    return ids;
  }

  @override
  void initState() {
    episodesController.getEpisode(widget.id).then((value) {
      List<int> ids = getIds(value.characters);

      episodesController.getListOfCharacters(ids);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                buildImage(),
                buildTitle(),
                const SliverToBoxAdapter(
                  child: TabBar(
                  indicator: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.red, width: 3),
                    ),
                  ),
                  isScrollable: true,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(child: Text('Informações')),
                    Tab(child: Text('Personagens')),
                  ],
                ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                buildInfo(),
                buildCharacterEpisodes(),
              ],
            ),
          ),
        ),
      ),
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

  Widget buildImage() {
    Size size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: size.height * 0.30,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          height: size.height * 0.3,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/rickandmortyapi.jpg'),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            width: size.width,
            child: episodesController.hasEpisode ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  episodesController.episode.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  DateFormat.yMd().format(episodesController.episode.created),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            )
            : const Center(),
          )
        );
      }
    );
  }

  Widget buildInfo() {
    return Observer(
      builder: (_) {
        return episodesController.hasEpisode
          ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: const Text(
                'Episódio',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Text(
                episodesController.episode.episode,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: const Text(
                'Data do AR',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Text(
                episodesController.episode.airDate,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        )
        : const Center();
      },
    );
  }

  Widget buildCharacterEpisodes() {
    return Observer(
      builder: (_) {
        return ListView.builder(
          itemCount: episodesController.characters.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(episodesController.characters[index].image),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(episodesController.characters[index].name),
              subtitle: Text(episodesController.characters[index].species),
              onTap: () => Modular.to.pushNamed('/character/${episodesController.characters[index].id}'),
            );
          },
        );
      },
    );
  }
}