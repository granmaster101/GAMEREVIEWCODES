import 'package:flutter/material.dart';
import 'games.dart';
import 'ratingbox.dart';


class ProductBox extends StatelessWidget {
  const ProductBox({super.key, required this.games});

  final Games games;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/appimages/' + this.games.image),
            Expanded(child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(this.games.name,
                  style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(this.games.description),
                  Text('Price:'+this.games.price.toString()),
                  RatingBox()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}