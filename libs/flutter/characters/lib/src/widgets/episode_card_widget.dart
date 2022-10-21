import 'package:flutter/material.dart';

class EpisodeCardWidget extends StatelessWidget {
  final int id;
  final String episode;
  final String name;

  const EpisodeCardWidget({Key? key, required this.id, required this.episode, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade200
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        onTap: () => print('Clicou no episódio $id'),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}