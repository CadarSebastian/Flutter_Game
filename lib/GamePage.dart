import 'package:flutter/material.dart';
import 'dart:async'; 

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double entityX = 0.0;
  double entityY = 0.0;
  late Timer continuousMovementTimer; 

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
                bottom: 16.0,
                left: 16.0,
                child: Row(
                  children: [
                    // Left Button
                    GestureDetector(
                      onLongPressStart: (details) {
                        startContinuousMovement(-10.0, 0.0);
                      },
                      onLongPressMoveUpdate: (details) {
                        // To handle movement updates
                      },
                      onLongPressEnd: (details) {
                        stopContinuousMovement();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          moveEntity(-10.0, 0.0);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    // Right Button
                    GestureDetector(
                      onLongPressStart: (details) {
                        startContinuousMovement(10.0, 0.0);
                      },
                      onLongPressMoveUpdate: (details) {
                        // To handle movement updates
                      },
                      onLongPressEnd: (details) {
                        stopContinuousMovement();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          moveEntity(10.0, 0.0);
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 72.0,
                left: 64.0,
                child: Column(
                  children: [
                    // Up Button
                    GestureDetector(
                      onLongPressStart: (details) {
                        startContinuousMovement(0.0, -10.0);
                      },
                      onLongPressMoveUpdate: (details) {
                        // To handle movement updates
                      },
                      onLongPressEnd: (details) {
                        stopContinuousMovement();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          moveEntity(0.0, -10.0);
                        },
                        child: Icon(Icons.arrow_upward),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Down Button
                    GestureDetector(
                      onLongPressStart: (details) {
                        startContinuousMovement(0.0, 10.0);
                      },
                      onLongPressMoveUpdate: (details) {
                        // To handle movement updates
                      },
                      onLongPressEnd: (details) {
                        stopContinuousMovement();
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          moveEntity(0.0, 10.0);
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

  void moveEntity(double dx, double dy) {
    setState(() {
      entityX += dx;
      entityY += dy;
    });
  }

  void startContinuousMovement(double dx, double dy) {
    // Start continuous movement by using a timer or other mechanism
    continuousMovementTimer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
      moveEntity(dx, dy);
    });
  }

  void stopContinuousMovement() {
    
    continuousMovementTimer.cancel();
  }
}
