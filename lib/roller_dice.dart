import 'dart:math';

import 'package:flutter/material.dart';

class GameRollerDice extends StatefulWidget {
  const GameRollerDice({super.key});
  

  @override
  State<GameRollerDice> createState() => _GameRollerDiceState();
}

class _GameRollerDiceState extends State<GameRollerDice> {
  var diceNumber=1;

  void roll(){
    setState(() {
      diceNumber=Random().nextInt(6)+1;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/dice-$diceNumber.png',
              width: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(onPressed: roll, 
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 85, 62, 53),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 28)
              ),
              child: const Text('Role Once'))
            ],
            );
  }
}
