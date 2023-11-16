import 'package:dice/dice_page.dart';
import 'package:flutter/material.dart';

class RollerDiceApp extends StatelessWidget{
  const RollerDiceApp({super.key});
 @override
Widget build(BuildContext context) {
  return const MaterialApp(
    home: Scaffold(
          body: const DicePage(colors:[
          Color.fromARGB(255, 5, 33, 10),
          Color.fromARGB(255, 5, 33, 10),
          Color.fromARGB(255, 5, 33, 10)
          ]),
      ),
  );
}
}