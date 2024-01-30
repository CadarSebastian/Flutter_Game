import 'dart:async';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'common.dart';  

/// Pagina jocului - StatefulWidget
class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

/// Starea paginii jocului
class _GamePageState extends State<GamePage> {
  /// Variabilele pentru poziția jucătorului, the loop și scor
  double entityX = 400;
  double entityY = 470;
  bool _loopActive = false;
  int _number = 0;

  /// Timerul pentru boulders
  late Timer _timer;

  /// Lista pt boulders
  List<Circle> circles = [];

  @override
  void initState() {
    super.initState();

    /// timer pentru boulder generation
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      setState(() {
        _number += 5;
        circles.add(Circle());
      });
    });

    /// Limitele ecranului
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      });
    });

    /// boulder se misca every ... microsecnds
    Timer.periodic(const Duration(microseconds: 1), (timer) {
      moveCircles();
    });
  }

  /// functie pentu falling boulders
  void moveCircles() {
    for (Circle circle in List.from(circles)) {
      if (!circle.isMoving) {
        circle.isMoving = true;
      }

      circle.y += 10.0;

      if (circle.y > screenHeight) {
        circles.remove(circle);
        /// print(1);
        
      }

      /// collision check
      if (entityX < circle.x + Circle.radius &&
          entityX + 100.0 > circle.x &&
          entityY < circle.y + Circle.radius &&
          entityY + 100.0 > circle.y) {
        _timer.cancel();
        /// You died alert
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Ai pierdut!'),
              content: Text('Scorul tău: $_number'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: const Text('Încearcă din nou'),
                ),
              ],
            );
          },
        );
      }
    }

    setState(() {});
  }

  /// functia de movement
  void _startContinuousMovement(double dx) {
    if (_loopActive) return;

    _loopActive = true;

    Future.doWhile(() async {
      double newEntityX = entityX + dx;
/// verifica daca iese afara din screen
      if (newEntityX >= 0 && newEntityX <= screenWidth - 100.0) {
        entityX = newEntityX;
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
        // img de funadl
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://media.istockphoto.com/id/1333010525/vector/simple-flat-pixel-art-illustration-of-cartoon-outdoor-landscape-background-pixel-arcade.jpg?s=612x612&w=0&k=20&c=uTGqB9fhmjzaNd17EGRHYU04_70K7a3M8ilRoJjDwtY='),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              /// jucatoru
              Positioned(
                left: entityX,
                top: entityY,
                child: Image.asset(
                  'assets/caracter.png',
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              /// generarea boulders
              for (Circle circle in circles)
                Positioned(
                  left: circle.x,
                  top: circle.y,
                  child: CircleWidget(),
                ),
              /// Scoru
              Positioned(
                top: 10.0,
                right: 10.0,
                child: Text(
                  'Scor: $_number',
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              /// Butoanele
              Positioned(
                bottom: 30.0,
                left: 18.0,
                child: Row(
                  children: [
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(-5.0);
                      },
                      onPointerUp: (details) {
                        _loopActive = false;
                      },
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 1110.0),
                    Listener(
                      onPointerDown: (details) {
                        _startContinuousMovement(5.0);
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

/// Blouder hitbox
class Circle {
  static const double radius = 50.0;
  double x = 0.0;
  double y = 0.0;
  bool isMoving = false;

  Circle() {
    /// random boulder pozition
    x = Circle.radius +
        (Math.Random().nextDouble() * (screenWidth - Circle.radius));
    y = -Circle.radius; 
  }
}

/// imaginea de boulder
class CircleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://cdn.polyhaven.com/asset_img/thumbs/rock_boulder_dry.png?format=png',
      width: Circle.radius * 2,
      height: Circle.radius * 2,
    );
  }
}
