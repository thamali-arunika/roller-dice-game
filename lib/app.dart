import 'package:dice/dice_page.dart';
import 'package:flutter/material.dart';

class RollerDiceApp extends StatelessWidget{
  const RollerDiceApp({super.key});
 @override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(205,133,69, 41),
         title: const Text('Roller Dice Game'),
         centerTitle: true,
          ),
          body: const DicePage(colors:[
          Color.fromARGB(255, 12, 33, 16),
          Color.fromARGB(255, 12, 33, 16),
          Color.fromARGB(255, 12, 33, 16)
          ]),
      ),
  );
}
}