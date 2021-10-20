// ignore_for_file: file_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';

class PokeHubProvider {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub = PokeHub.fromJson({});

  static PokeHubProvider instance = PokeHubProvider();
  fetchData() async {
    try {
      var _response = await Dio().get(url);
      var decodedJson = jsonDecode(_response.data);
      pokeHub = PokeHub.fromJson(decodedJson);
      // notifyListeners();
    } catch (e) {
      print(e.toString());
      pokeHub = PokeHub.fromJson({});
    }
  }
}
