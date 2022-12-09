import 'package:flutter/material.dart';
import 'games.dart';
import 'ratingbox.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.games});
  final  Games games;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.games.name),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/appimages/'+ this.games.image),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(this.games.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(this.games.description),
                      Text('Price:'+ this.games.price.toString()),
                      RatingBox(),
                    ],
                  ),
                ),
              )
            ],

          ),)),
    );
  }
}