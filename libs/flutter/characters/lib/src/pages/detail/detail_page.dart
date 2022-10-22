import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/detail/detail_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

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
        appBar: AppBarWidget(
          title: 'Detalhe',
          centerTitle: true,
          showSearch: false,
          onPressedLeadingIcon: () => Modular.to.pop(),
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
                      Tab(child: Text('Episódios ')),
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
            ) : const SkeletonAvatar(
              style: SkeletonAvatarStyle(),
            ),
          ),
        );
      },
    );
  }

  Widget buildTitle() {
    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: SkeletonListTileWidget(
            isLoading: !detailController.hasCharacter,
            child: detailController.hasCharacter ? Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey.shade200)
                )
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(detailController.character.name, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(DateFormat.yMd().format(detailController.character.created)),
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
          isLoading: !detailController.hasCharacter,
          child: detailController.hasCharacter ? ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 16
                ),
                child: Wrap(
                  children: [
                    GenereicLabelWidget(label: detailController.character.status),
                    GenereicLabelWidget(label: detailController.character.species),
                    GenereicLabelWidget(label: detailController.character.gender),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: const Text('Origin', style: TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(detailController.character.origin.name),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: const Text('Location', style: TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(detailController.character.location.name),
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
          isLoading: !detailController.hasEpisodes,
          child: ListView.builder(
            itemCount: detailController.episodes.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                leading: CircleAvatar(
                  backgroundImage: const AssetImage(Assets.imgRickMorty),
                  backgroundColor: Colors.grey[300]
                ),
                title: Text(detailController.episodes[index].episode, style: const TextStyle(fontWeight: FontWeight.w700),),
                subtitle: Text(detailController.episodes[index].name),
                onTap: () => Modular.to.pushNamed('/episode/${detailController.episodes[index].id}'),
              );
            },
          )
        );
      },
    );
  }
}
