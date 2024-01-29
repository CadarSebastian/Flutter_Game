// game_page.dart
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double entityX = 0.0;
  double entityY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJCyMsO83lYVVJwj0iP-DhHsaB6Xs1-NMF0A&usqp=CAU'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.network(
              '', // Replace with your image URL
              width: 50.0,
              height: 50.0,
          ),
        ),
      ),
    );
  }
}
