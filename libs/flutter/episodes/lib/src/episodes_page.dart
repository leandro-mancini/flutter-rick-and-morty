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
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(episodesController.episode.name, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(DateFormat.yMd().format(episodesController.episode.created)),
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
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(episodesController.episode.episode, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: const Text('Episódio'),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(episodesController.episode.airDate, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: const Text('Data do AR'),
              )
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
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(episodesController.characters[index].image),
                  backgroundColor: Colors.grey[300]
                ),
                title: Text(episodesController.characters[index].name, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(episodesController.characters[index].species),
                onTap: () => Modular.to.pushNamed('/character/${episodesController.characters[index].id}'),
              );
            },
          )
        );
      },
    );
  }
}