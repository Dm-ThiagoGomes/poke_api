// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';

class MyHomePage extends StatefulWidget {
  final String title = "Home Test";

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PokeHub pokeHub = PokeHub.fromJson({});
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      fetchData();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: pokeHub.pokemon
                .map((pokedex) => Card(
                        child: Column(children: [
                      Container(
                          height: 200,
                          width: 200,
                          child: Image.network(pokedex.img)),
                      Text(pokedex.name),
                    ])))
                .toList()));
  }
}
