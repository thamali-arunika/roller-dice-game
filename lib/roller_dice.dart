import 'dart:math';

import 'package:flutter/material.dart';

class RollerDice extends StatefulWidget {
  const RollerDice({Key? key}) : super(key: key);

  @override
  State<RollerDice> createState() => _RollerDiceState();
}

class _RollerDiceState extends State<RollerDice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  int currentPlayer = 1;
  int player1Score = 0;
  int player2Score = 0;
  int currentRound = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _rotationAnimation = Tween<double>(begin: 10, end: 60).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
  }

  int diceNum = 1;
  void roll() {
    setState(() {
      diceNum = Random().nextInt(6) + 1;
    });

    // Reset the controller to its initial state
    _controller.reset();

    // Simultaneously start the rotation and scaling animations
    _controller.forward();

    // Update the score based on the current player
    if (currentPlayer == 1) {
      player1Score += diceNum;
    } else {
      player2Score += diceNum;
    }

    // Switch to the next player
    currentPlayer = (currentPlayer == 1) ? 2 : 1;

    // Check for the winner after 5 rounds
    if (currentRound == 5) {
      int winner = (player1Score > player2Score) ? 1 : 2;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Player $winner wins!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    } else {
      currentRound++;
    }
  }

  void resetGame() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
      currentRound = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: _rotationAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              'assets/images/dice-$diceNum.png',
              width: 180,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'Player $currentPlayer',
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold,
             color: Colors.white,
            
          ),
          
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Player 1 Score: $player1Score',
          style: TextStyle(fontSize: 18, color: Colors.white,),
        ),
        Text(
          'Player 2 Score: $player2Score',
          style: TextStyle(fontSize: 18, color: Colors.white,),
        ),
        Text(
          'Round: $currentRound / 5',
          style: TextStyle(fontSize: 18, color: Colors.white,),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: roll,
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 28),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}