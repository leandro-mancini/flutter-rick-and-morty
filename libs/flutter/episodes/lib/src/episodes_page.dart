import 'package:flutter/material.dart';
import 'package:flutter_episodes/src/episodes_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';
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
        appBar: AppBarWidget(
          title: 'Episódio',
          centerTitle: true,
          showSearch: false,
          onPressedLeadingIcon: () => Modular.to.pop(),
        ),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                buildImage(),
                buildTitle(),
                const SliverToBoxAdapter(
                  child: TabBar(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
              image: AssetImage('assets/images/rickandmortyapi.jpg'),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: SkeletonListTileWidget(
            isLoading: !episodesController.hasEpisode,
            child: episodesController.hasEpisode ? Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey.shade200)
                )
              ),
              child: ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: episodesController.episode.name,
                subtitle: DateFormat.yMd().format(episodesController.episode.created),
              ),
            ) : Container(),
          ),
        );
      }
    );
  }

  Widget buildInfo() {
    return Observer(
      builder: (_) {
        return SkeletonListWidget(
          itemCount: 3,
          hasLeading: false,
          isLoading: !episodesController.hasEpisode,
          child: episodesController.hasEpisode ? ListView(
            children: [
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: episodesController.episode.episode,
                subtitle: 'Episódio',
              ),
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: episodesController.episode.airDate,
                subtitle: 'Data do AR',
              ),
            ],
          ) : Container(),
        );
      },
    );
  }

  Widget buildCharacterEpisodes() {
    return Observer(
      builder: (_) {
        return SkeletonListWidget(
          itemCount: 10,
          isLoading: !episodesController.hasCharacters,
          child: ListView.builder(
            itemCount: episodesController.characters.length,
            itemBuilder: (context, index) {
              return ListTileWidget(
                title: episodesController.characters[index].name,
                subtitle: episodesController.characters[index].species,
                backgroundImage: NetworkImage(episodesController.characters[index].image),
                onTap: () => Modular.to.pushNamed('/characters/character/${episodesController.characters[index].id}'),
              );
            },
          )
        );
      },
    );
  }
}