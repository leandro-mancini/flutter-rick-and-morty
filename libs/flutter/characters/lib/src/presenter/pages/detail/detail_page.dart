import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_shared/flutter_shared.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

import 'detail_controller.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final controller = Modular.get<DetailController>();

  @override
  void initState() {
    controller.getCharacter(widget.id);
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
      title: 'Detalhe',
      centerTitle: true,
      showSearch: false,
      onPressedLeadingIcon: () => Modular.to.pop(),
      actions: [
        Observer(
          builder: (_) {
            return controller.hasCharacter ? IconButton(
              icon: controller.hasFavorite ? const Icon(
                Icons.favorite,
                color: Colors.red,
              ) : const Icon(
                Icons.favorite_outline,
                color: Colors.black87,
              ),
              onPressed: () {
                controller.addCharacterToFavorite(
                  controller.character,
                  controller.hasFavorite
                );
              }
            ) : Container();
          },
        ),
      ],
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
                  Tab(child: Text('Episódios ')),
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

    return Observer(
      builder: (_) {
        return SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: size.height * 0.30,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: controller.hasCharacter ? Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(controller.character.image),
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

  Widget _buildTitle() {
    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: SkeletonListTileWidget(
            isLoading: !controller.hasCharacter,
            child: controller.hasCharacter ? Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey.shade200)
                )
              ),
              child: ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: controller.character.name,
                subtitle: DateFormat.yMd().format(controller.character.created),
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
          isLoading: !controller.hasCharacter,
          child: controller.hasCharacter ? ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 16
                ),
                child: Wrap(
                  children: [
                    GenereicLabelWidget(label: controller.character.status),
                    GenereicLabelWidget(label: controller.character.species),
                    GenereicLabelWidget(label: controller.character.gender),
                  ],
                ),
              ),
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: 'Origin',
                subtitle: controller.character.origin.name,
              ),
              ListTileWidget(
                enabled: false,
                hasLeading: false,
                title: 'Location',
                subtitle: controller.character.location.name,
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
          isLoading: !controller.hasEpisodes,
          child: ListView.builder(
            itemCount: controller.episodes.length,
            itemBuilder: (context, index) {
              return ListTileWidget(
                title: controller.episodes[index].episode,
                subtitle: controller.episodes[index].name,
                backgroundImage: const AssetImage(Assets.imgRickMorty),
                onTap: () => Modular.to.pushNamed('/episode/${controller.episodes[index].id}').then((value) => controller.getCharacter(widget.id)),
              );
            },
          )
        );
      },
    );
  }
}