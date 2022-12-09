import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginandsignup/games.dart';
import 'package:loginandsignup/main.dart';
import 'package:loginandsignup/ratingmain.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final CollectionReference<Map<String, dynamic>> _referenceGames =
      FirebaseFirestore.instance.collection('Games');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.games),
            SizedBox(width: 10),
            Text('Game reviews')
          ],
        ),
      ),
      body: StreamBuilder<List<GameFirestoreModel>>(
        stream: _referenceGames
            .snapshots()
            .map((event) => GameFirestoreModel.getList(event)),
        builder: (_, AsyncSnapshot<List<GameFirestoreModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              /// return a list view from here
              return ListView.builder(
                itemCount: (snapshot.data ?? []).length,
                itemBuilder: (_, int index) {
                  // get a game model
                  final GameFirestoreModel game = snapshot.data!.elementAt(index);
                  return Card(
                    child: Column(
                      children: [
                        Text("Game name: ${game.name}",),
                        Text("Game price: ${game.price}",),
                        Text("Game genre: ${game.genre}",),
                        Text("Game description: ${game.description}",),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No Document Found"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // Add the FlatButton widget here
      floatingActionButton: FloatingActionButton(
        mini: false,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => MyHomePage2(title: '')),
            ),
          );
          // Perform some action when the button is pressed
        },
        child: const Text(
          'Game Reviews Page',
          style: TextStyle(fontSize: 13),
        ),
        backgroundColor: Colors.blue,
        elevation: 5.0,
      ),
    );
  }
}

@immutable
class GameFirestoreModel {
  final String name;
  final String price;
  final String description;
  final String genre;
  const GameFirestoreModel({
    this.name = "",
    this.price = "",
    this.description = "",
    this.genre = "",
  });

  factory GameFirestoreModel.fromQuerydoc(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    try {
      // make sure document has data
      if (doc.exists && doc.data().isNotEmpty && doc.id.isNotEmpty) {
        return GameFirestoreModel(
          name: doc.data()["Name"].toString(),
          price: doc.data()["Price"].toString(),
          genre: doc.data()["Genre"].toString(),
          description: doc.data()["Description"].toString(),
        );
      }
    } catch (e) {
      // print erorr in debug console
      if (kDebugMode) {
        log("Game Model error: ${e.toString()}");
      }
    }
    // document deson' have any data so return a empty model from here
    return const GameFirestoreModel();
  }

  static List<GameFirestoreModel> getList(
      QuerySnapshot<Map<String, dynamic>> data) {
    // Check if data parameter have documents inside then convert querydocument into Model
    if (data.docs.isNotEmpty) {
      return List<GameFirestoreModel>.from(
          data.docs.map((e) => GameFirestoreModel.fromQuerydoc(e)));
    }
    // data parameter doesn' have any document so return list of game models
    return <GameFirestoreModel>[];
  }
}
