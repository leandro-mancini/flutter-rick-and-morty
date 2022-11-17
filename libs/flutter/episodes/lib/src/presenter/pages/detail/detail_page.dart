import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:intl/intl.dart';

import 'detail_controller.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailController controller = Modular.get<DetailController>();

  @override
  void initState() {
    controller.getEpisode(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
      )
    );
  }

  AppBarWidget _buildAppBar() {
    return AppBarWidget(
      title: 'Episódio',
      centerTitle: true,
      showSearch: false,
      onPressedLeadingIcon: () => Modular.to.pop(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildImage(),
            _buildTitle(),
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
            _buildInfo(),
            _buildCharacterEpisodes(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
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

  Widget _buildTitle() {
    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: SkeletonListTileWidget(
            isLoading: !controller.hasEpisode,
            child: controller.hasEpisode ? Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey.shade200)
                )
              ),
              child: ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: controller.episode.name,
                subtitle: DateFormat.yMd().format(controller.episode.created),
              ),
            ) : Container(),
          ),
        );
      }
    );
  }

  Widget _buildInfo() {
    return Observer(
      builder: (_) {
        return SkeletonListWidget(
          itemCount: 3,
          hasLeading: false,
          isLoading: !controller.hasEpisode,
          child: controller.hasEpisode ? ListView(
            children: [
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: controller.episode.episode,
                subtitle: 'Episódio',
              ),
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: controller.episode.airDate,
                subtitle: 'Data do AR',
              ),
            ],
          ) : Container(),
        );
      },
    );
  }

  Widget _buildCharacterEpisodes() {
    return Observer(
      builder: (_) {
        return SkeletonListWidget(
          itemCount: 10,
          isLoading: !controller.hasCharacters,
          child: ListView.builder(
            itemCount: controller.characters.length,
            itemBuilder: (context, index) {
              return ListTileWidget(
                title: controller.characters[index].name,
                subtitle: controller.characters[index].species,
                backgroundImage: NetworkImage(controller.characters[index].image),
                onTap: () => Modular.to.pushNamed('/characters/character/${controller.characters[index].id}').then((value) => controller.getEpisode(widget.id)),
              );
            },
          )
        );
      },
    );
  }
}