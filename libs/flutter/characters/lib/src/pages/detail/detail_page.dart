import 'package:flutter/material.dart';
import 'package:flutter_characters/src/pages/detail/detail_controller.dart';
import 'package:flutter_characters/src/widgets/generic_label_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

      detailController.getListOfEpisodes(ids);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildImage(),
            buildTitle(),
            buildInfo(),
            buildOriginLocation(),
            buildCharacterEpisodes(),
          ],
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
        IconButton(
          icon: const Icon(
            Icons.favorite_outline,
            color: Colors.black87,
          ),
          onPressed: () => print('Clicou em favoritar'),
        ),
      ],
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
                  detailController.character.created.toString(),
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
        return SliverToBoxAdapter(
          child: detailController.hasCharacter
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
          : const Center(),
        );
      },
    );
  }

  Widget buildOriginLocation() {
    return Observer(
      builder: (_) {
        return SliverToBoxAdapter(
          child: detailController.hasCharacter ? Column(
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
                onTap: () {},
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
                onTap: () {},
              ),
            ],
          )
        : const Center());
      },
    );
  }

  Widget buildCharacterEpisodes() {
    return Observer(
      builder: (_) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: const NetworkImage('https://www.programmableweb.com/sites/default/files/rickandmortyapi.jpg'),
                  backgroundColor: Colors.grey[300]
                ),
                title: Text(
                  detailController.episodes[index].episode,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                subtitle: Text(
                  detailController.episodes[index].name,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onTap: () {},
              );
            },
            childCount: detailController.episodes.length
          ),
        );
      },
    );
  }
}
