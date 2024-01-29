// game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      body: Focus(
        onKey: (FocusNode node, RawKeyEvent event) {
          return handleKeyEvent(event);
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJCyMsO83lYVVJwj0iP-DhHsaB6Xs1-NMF0A&usqp=CAU'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Positioned(
              left: entityX,
              top: entityY,
              child: Image.asset(
                'assets/caracter.png',
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  KeyEventResult handleKeyEvent(RawKeyEvent event) {
    const double step = 10.0; // Adjust the step size as needed

    if (event is RawKeyDownEvent) {
      setState(() {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          entityX -= step;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          entityX += step;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          entityY -= step;
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          entityY += step;
        }
      });
    }

    // Return a value of type KeyEventResult
    return KeyEventResult.handled;
  }
}
