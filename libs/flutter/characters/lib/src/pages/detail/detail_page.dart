import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/detail/detail_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = DetailController();

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
    detailController.getCharacter(widget.id).then((value) {
      List<int> ids = getIds(value.episode);

      detailController.getFavorites();
      detailController.checkCharacterFavorite(value);
      detailController.getListOfEpisodes(ids);
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
                    Tab(child: Text('Episódios ')),
                  ],
                ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                ListView(
                  children: [
                    buildInfo(),
                    buildOriginLocation(),
                  ],
                ),
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
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: const Text('Detalhe', style: TextStyle(color: Colors.black87, fontSize: 18),),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.black87,
        ),
        onPressed: () => Modular.to.pop(),
      ),
      actions: [
        Observer(
          builder: (_) {
            return detailController.hasCharacter ? IconButton(
              icon: detailController.hasFavorite ? const Icon(
                Icons.favorite,
                color: Colors.red,
              ) : const Icon(
                Icons.favorite_outline,
                color: Colors.black87,
              ),
              onPressed: () {
                detailController.addCharacterToFavorite(
                  detailController.character,
                  detailController.hasFavorite
                );
              }
            ) : Container();
          },
        ),
      ],
    );
  }

  buildTabBar() {
    return Observer(
      builder: (_) {
        return detailController.hasCharacter ? SliverToBoxAdapter(
          child: TabBar(
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.red, width: 3),
              ),
            ),
            isScrollable: true,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
            tabs: [
              const Tab(child: Text('Informações')),
              Tab(child: Text('Episódios (${detailController.episodes.length})')),
            ],
          ),
        ) : Container();
      },
    );
  }

  Widget buildImage() {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) {
        return SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: size.height * 0.30,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: detailController.hasCharacter ? Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(detailController.character.image),
                ),
              ),
            ) : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
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
            child: detailController.hasCharacter ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailController.character.name,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  DateFormat.yMd().format(detailController.character.created),
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
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) {
        return detailController.hasCharacter
          ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width,
                  child: const Text(
                    'Inforamções',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Wrap(
                    children: [
                      GenereicLabelWidget(label: detailController.character.status),
                      GenereicLabelWidget(label: detailController.character.species),
                      GenereicLabelWidget(label: detailController.character.gender),
                    ],
                  ),
                )
              ],
            ),
          )
        : const Center();
      },
    );
  }

  Widget buildOriginLocation() {
    return Observer(
      builder: (_) {
        return detailController.hasCharacter ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: const Text(
                'Origin',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Text(
                detailController.character.origin.name,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: const Text(
                'Location',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Text(
                detailController.character.location.name,
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
        return ListView(
          children: detailController.episodes.map((item) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/rickandmortyapi.jpg'),
                backgroundColor: Colors.grey[300]
              ),
              title: Text(
                item.episode,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              subtitle: Text(
                item.name,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
              onTap: () => Modular.to.pushNamed('/episode/${item.id}'),
            );
          }).toList(),
        );
      },
    );
  }
}
