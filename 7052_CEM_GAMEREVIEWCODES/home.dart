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
  int _counter =0;

  CollectionReference _referenceGames = FirebaseFirestore.instance.collection('Games');
  late Stream<QuerySnapshot> _streamgames;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }
  initState() {
    // TODO: implement initState
    
    _streamgames=_referenceGames.snapshots();
  }
  @override
  Widget build(BuildContext context) {
    _referenceGames.get();
    _referenceGames.snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.games),
          SizedBox(width: 10),
          Text('Game reviews')
        ]),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:_streamgames,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasError)
          {
            return Center(child: Text(snapshot.error.toString()));
          }
          else if (snapshot.connectionState==ConnectionState.active)
          {
            QuerySnapshot querySnapshot=snapshot.data;
            return Center(child: Text('Number of documents: ${snapshot.data.documents.length}'),);

          }
          else return Center(child: CircularProgressIndicator());

        },
      ),
      // Add the FlatButton widget here
      floatingActionButton: FloatingActionButton(
        mini: false,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => MyHomePage2(title: '',))));
          // Perform some action when the button is pressed
        },
        child: Text('Game Reviews Page',style: TextStyle(fontSize: 13),),
        backgroundColor: Colors.blue,
        elevation: 5.0,
      ),
    );
  }
}
