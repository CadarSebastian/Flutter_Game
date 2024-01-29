import 'package:flutter/material.dart';
import 'GamePage.dart'; // Import the new game page file
import 'HomePage.dart';

void main (){
  runApp(const flutter_game());
}

// ignore: camel_case_types
class flutter_game extends StatelessWidget {
  const flutter_game({super.key});

 

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:false ,
      home: HomePage(),

    );
  }
}