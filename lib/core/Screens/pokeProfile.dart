// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/mainPage.dart';

class PokeProfile extends StatelessWidget {
  final PokeHub pokeHub;
  final int id;

  PokeProfile({Key? key, required this.pokeHub, required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pokeHub.pokemon[id].name),
        ),
        body: Column(children: [
          Center(
            child: SizedBox(
                height: 200,
                width: 200,
                child: Column(children: [
                  Image.network(
                    pokeHub.pokemon[id].img,
                    scale: 1,
                  ),
                  Text(pokeHub.pokemon[id].name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                ])),
          ),
        ]));
  }
}
