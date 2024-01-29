import 'package:flutter/material.dart';
import 'GamePage.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage())
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
      ],
    );
  }
}
