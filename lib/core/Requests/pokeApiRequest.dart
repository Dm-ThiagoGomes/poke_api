// ignore_for_file: file_names
import 'package:dio/dio.dart';

class Pokemon {
  final String pokeName;
  var url = Uri.parse('https://pokeapi.co/api/v2/');

  Pokemon(this.pokeName);

  void getHttp<T>() async {}
}
