import 'package:flutter/material.dart';
import 'GamePage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10), // Adjust the duration as needed
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red[800],
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(100.0),
            child: Text(
              'Survive The',
              style: TextStyle(
                color: Colors.white,
                fontSize: 100.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GamePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20.0),
              primary: const Color.fromARGB(255, 104, 2, 18),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.play_arrow,
                size: 40.0,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RotationTransition(
              turns: _controller,
              child: Image.network(
                'https://cdn.polyhaven.com/asset_img/thumbs/rock_boulder_dry.png?format=png',
                height: 300.0,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RotationTransition(
              turns: _controller,
              child: Image.network(
                'https://cdn.polyhaven.com/asset_img/thumbs/rock_boulder_dry.png?format=png',
                height: 300.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
