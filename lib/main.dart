import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title = "Home Test";

  @override
  State<MyHomePage> createState() => _MyHomePageState(PokeHub([]));
}

class _MyHomePageState extends State<MyHomePage> {
  PokeHub pokeHub;
  _MyHomePageState(this.pokeHub);
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
              .map((poke) => Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                      child: Text(poke.name,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )))))
              .toList(),
        ));
  }
}
