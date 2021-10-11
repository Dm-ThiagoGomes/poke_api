// ignore_for_file: file_names

import 'dart:collection';
import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  PokeHub _pokeHub = PokeHub.fromJson({});

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var _response = await Dio().get(url);
      var decodedJson = jsonDecode(_response.data);
      _pokeHub = PokeHub.fromJson(decodedJson);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  void loadMore() {
    setState(() {
      if (hidedPokes < _pokeHub.pokemon.length) {
        hidedPokes += 12;
        if (hidedPokes >= _pokeHub.pokemon.length) {
          hidedPokes = _pokeHub.pokemon.length;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var pokedex = _pokeHub.then();

    return FutureBuilder(
        future: Dio().get(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: PokeGridView(
                hidedPokes: hidedPokes,
                pokeHub: _pokeHub,
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
