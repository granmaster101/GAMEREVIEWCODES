

import 'package:flutter/material.dart';

class RatingBox extends StatefulWidget {

  @override
  
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 0 ;

  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });

  }

  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }

  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }

  void _setRatingAsFour() {
    setState(() {
      _rating = 4;
    });
  }
  void _setRatingAsFive() {
    setState(() {
      _rating = 5;
    });
  }
  @override
  Widget build(BuildContext context) {
    double _size=26;
    print(_rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
              _rating>=1?
              Icon(Icons.star,size: _size,):
              Icon(Icons.star_border,size: _size,)
            ),
            color: Colors.red,
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
              _rating>=2?
              Icon(Icons.star,size: _size,):
              Icon(Icons.star_border,size: _size,)
            ),
            color: Colors.red,
            onPressed: _setRatingAsTwo,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
              _rating>=3?
              Icon(Icons.star,size: _size,):
              Icon(Icons.star_border,size: _size,)
            ),
            color: Colors.red,
            onPressed: _setRatingAsThree,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
              _rating>=4?
              Icon(Icons.star,size: _size,):
              Icon(Icons.star_border,size: _size,)
            ),
            color: Colors.red,
            onPressed: _setRatingAsFour,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (
              _rating>=5?
              Icon(Icons.star,size: _size,):
              Icon(Icons.star_border,size: _size,)
            ),
            color: Colors.red,
            onPressed: _setRatingAsFive,
            iconSize: _size,
          ),
        ),

      ],
    );
  }
}