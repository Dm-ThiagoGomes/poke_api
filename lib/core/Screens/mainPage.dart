// ignore_for_file: file_names

import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/pokeProfile.dart';

class MyHomePage extends StatefulWidget {
  final String title = "Pokedex";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PokeHub pokeHub = PokeHub.fromJson({});

  var pokes = <String>[];

  int perPage = 15;
  int present = 0;

  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  bool t = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData();
    }
  }

  int hidedPokes = 12;

  void fetchData() async {
    try {
      var response = await Dio().get(url);
      var decodedJson = jsonDecode(response.data);
      pokeHub = PokeHub.fromJson(decodedJson);
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  void loadMore() {
    setState(() {
      if (hidedPokes <= pokeHub.pokemon.length - 5) {
        hidedPokes += 12;
      } else {
        hidedPokes += 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pokedex = pokeHub.pokemon.asMap();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
          itemCount:
              pokeHub.pokemon.length - (pokeHub.pokemon.length - hidedPokes),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 1,
          ),
          itemBuilder: (BuildContext context, index) {
            return Card(
                child: Column(children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    pokedex[index]!.img,
                    scale: 1,
                  )),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PokeProfile(
                              pokeHub: this.pokeHub,
                            ))),
                child: Text(pokedex[index]!.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ),
            ]));
          }),
      bottomSheet: Container(
          height: 100,
          width: 100,
          child: TextButton(
              onPressed: () => loadMore(),
              child: Text(
                "Ver Mais +",
                style: TextStyle(fontSize: 15),
              ))),
    );
  }
}
