// ignore_for_file: file_names

import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_api/core/Providers/pokeHub_provider.dart';

import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/pokeGridView.dart';
import 'package:poke_api/core/Screens/pokeProfile.dart';

class MyHomePage extends StatefulWidget {
  final String title = "Pokedex";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  int hidedPokes = 12;
  // var pokemon = PokeHubProvider.instance.pokeHub;

  @override
  void initState() {
    super.initState();
    PokeHubProvider.instance.fetchData();
  }

  void loadMore() {
    setState(() {
      if (hidedPokes < PokeHubProvider.instance.pokeHub.pokemon.length) {
        hidedPokes += 12;
        if (hidedPokes >= PokeHubProvider.instance.pokeHub.pokemon.length) {
          hidedPokes = PokeHubProvider.instance.pokeHub.pokemon.length;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Dio().get(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              width: 200,
                              height: 20,
                              child: TextFormField(
                                onSaved: (_) => {},
                              ),
                            ),
                          );
                        },
                      );
                    }),
                title: Text(widget.title),
              ),
              body: PokeGridView(
                hidedPokes: hidedPokes,
                pokeHub: PokeHubProvider.instance.pokeHub,
              ),
              bottomSheet: Container(
                  height: 100,
                  width: 100,
                  child: TextButton(
                      onPressed: () => loadMore(),
                      child: const Text(
                        "Ver Mais +",
                        style: TextStyle(fontSize: 15),
                      ))),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            );
          }
        });
  }
}
