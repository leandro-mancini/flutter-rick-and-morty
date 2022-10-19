import 'package:flutter/material.dart';
import 'package:flutter_api/flutter_api.dart';

class CharacterInfoWidget extends StatelessWidget {
  final String name;
  final String species;
  final String status;
  final String gender;
  final DateTime created;
  final CharacterLocation origin;
  final CharacterLocation location;

  const CharacterInfoWidget({
    Key? key,
    required this.name,
    required this.species,
    required this.status,
    required this.gender,
    required this.created,
    required this.origin,
    required this.location
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700
            ),
          ),
          Text(
            species,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.indigo
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500]
                  ),
                )
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[900]
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Gênero',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500]
                  ),
                )
              ),
              Text(
                gender,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[900]
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Data de criação',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500]
                  ),
                )
              ),
              Text(
                created.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[900]
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}