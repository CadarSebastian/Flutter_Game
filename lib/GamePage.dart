import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'common.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double entityX = 0.0;
  double entityY = 0.0;
  bool _loopActive = false;
  int _number = 0;
  late Timer _timer;

  List<Circle> circles = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _number += 5;
        // Create a new circle and add it to the list
        circles.add(Circle());
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      });
    });

    // Check for collisions every 100 milliseconds
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      checkCollisions();
      updateCircles(timer.tick);
    });
  }

  void checkCollisions() {
    for (Circle circle in circles) {
      if (entityX < circle.x + Circle.radius &&
          entityX + 100.0 > circle.x &&
          entityY < circle.y + Circle.radius &&
          entityY + 100.0 > circle.y) {
        _timer.cancel(); // Stop the timer
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('You Lost!'),
              content: Text('Your Score: $_number'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: Text('Go Again'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void updateCircles(int tick) {
    circles.removeWhere((circle) {
      return tick % (2.5 * 10) == 0;
    });
  }

  void _startContinuousMovement(double dx, double dy) {
    if (_loopActive) return;

    _loopActive = true;

    Future.doWhile(() async {
      double newEntityX = entityX + dx;
      double newEntityY = entityY + dy;

      if (newEntityX >= 0 && newEntityX <= screenWidth - 100.0) {
        entityX = newEntityX;
      }

      if (newEntityY >= 0 && newEntityY <= screenHeight - 100.0) {
        entityY = newEntityY;
      }

      setState(() {});

      await Future.delayed(const Duration(microseconds: 1));

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
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJCyMsO83lYVVJwj0iP-DhHsaB6Xs1-NMF0A&usqp=CAU',
            ),
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
              // Display circles on the ground using CircleWidget
              for (Circle circle in circles)
                Positioned(
                  left: circle.x,
                  top: circle.y,
                  child: CircleWidget(),
                ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: Text(
                  'Score: $_number',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
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
                        onPressed: () {},
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    // Right Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(5.0, 0.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.arrow_forward),
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
                        onPressed: () {},
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Down Button
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(0.0, 5.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.arrow_downward),
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Circle {
  static const double radius = 100.0;
  double x = 0.0;
  double y = 0.0;

  Circle() {
    // Generate random position for the circle
    x = Circle.radius +
        (Math.Random().nextDouble() * (800 - 2 * Circle.radius));
    y = Circle.radius +
        (Math.Random().nextDouble() * (500 - 2 * Circle.radius));
  }
}

class CircleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Circle.radius * 2,
      height: Circle.radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GamePage(),
  ));
}
