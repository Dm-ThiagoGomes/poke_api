import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poke_api/core/Providers/pokeHub_provider.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/MainPage.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
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
      home: const MyHomePage(),
    );
  }
}
