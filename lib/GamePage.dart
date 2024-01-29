import 'package:flutter/material.dart';
import 'dart:async'; 

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double entityX = 0.0;
  double entityY = 0.0;
  bool _loopActive = false;

  void _startContinuousMovement(double dx, double dy) {
    if (_loopActive) return;

    _loopActive = true;

    Future.doWhile(() async {
      
      setState(() {
        entityX += dx;
        entityY += dy;
      });

      
      await Future.delayed(Duration(microseconds: 1));

      
      return _loopActive;
    }).then((_) {
      _loopActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJCyMsO83lYVVJwj0iP-DhHsaB6Xs1-NMF0A&usqp=CAU'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                left: entityX,
                top: entityY,
                child: Image.asset(
                  'assets/caracter.png',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Positioned(
                bottom: 30.0,
                left: 18.0,
                child: Row(
                  children: [
                    // Left Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(-5.0, 0.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Right Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(5.0, 0.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 55.0,
                child: Column(
                  children: [
                    // Up Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(0.0, -5.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Icon(Icons.arrow_upward),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Down Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(0.0, 5.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
