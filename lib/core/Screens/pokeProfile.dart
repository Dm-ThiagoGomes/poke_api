// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/mainPage.dart';

class PokeProfile extends StatelessWidget {
  final PokeHub pokeHub;

  PokeProfile({Key? key, required this.pokeHub}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
          appBar: AppBar(
            title: Text(pokeHub.pokemon[1].name),
          ),
          body: GridView.builder(
              itemCount: 1,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (BuildContext context, index) {
                return Card(
                    child: Column(children: [
                  SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(
                        pokeHub.pokemon[index].img,
                        scale: 1,
                      )),
                  Text(pokeHub.pokemon[index].name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                ]));
              })),
    );
  }
}
