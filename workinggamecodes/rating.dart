import 'package:flutter/material.dart';
import 'package:loginandsignup/productbox.dart';
import 'package:loginandsignup/productpage.dart';
import 'package:loginandsignup/games.dart';
import 'package:loginandsignup/productbox.dart';
import 'games.dart';

class MyHomePage2 extends StatelessWidget {
  MyHomePage2({Key? key, required this.title}) : super(key: key);
  final String title;
  final game = Games.getGames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Review Page'),
      ),
      body: ListView.builder(
        itemCount: game.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ProductBox(
              games: game[index],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(games: game[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
