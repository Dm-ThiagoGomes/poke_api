// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:poke_api/core/Requests/pokeHub.dart';
import 'package:poke_api/core/Screens/pokeProfile.dart';

class PokeGridView extends StatefulWidget {
  final PokeHub pokeHub;
  final int hidedPokes;

  const PokeGridView(
      {Key? key, required this.pokeHub, required this.hidedPokes})
      : super(key: key);

  @override
  _PokeGridViewState createState() => _PokeGridViewState();
}

class _PokeGridViewState extends State<PokeGridView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: widget.pokeHub.pokemon.length -
              (widget.pokeHub.pokemon.length - widget.hidedPokes),
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
                    widget.pokeHub.pokemon[index].img,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    scale: 1,
                  )),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PokeProfile(
                              pokeHub: widget.pokeHub,
                              id: index,
                            ))),
                child: Text(widget.pokeHub.pokemon[index].name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ),
            ]));
          }),
    );
  }
}
