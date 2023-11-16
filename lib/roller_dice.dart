import 'dart:math';

import 'package:flutter/material.dart';

class GameDice extends StatefulWidget {
  const GameDice({Key? key}) : super(key: key);

  @override
  State<GameDice> createState() => _GameDiceState();
}

class _GameDiceState extends State<GameDice>
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
      duration: const Duration(seconds: 1),
    );

    _rotationAnimation = Tween<double>(begin: 7, end: 60).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
  }

  int diceNumber = 1;
  void roll() {
    setState(() {
      diceNumber = Random().nextInt(6) + 1;
    });

    // Reset the controller to its initial state
    _controller.reset();

    // Simultaneously start the rotation and scaling animations
    _controller.forward();

    // Update the score based on the current player
    if (currentPlayer == 1) {
      player1Score += diceNumber;
    } else {
      player2Score += diceNumber;
    }

    // Switch to the next player
    currentPlayer = (currentPlayer == 1) ? 2 : 1;

    // Check for the winner after 7 rounds
    if (currentRound == 7) {
      int winner = (player1Score > player2Score) ? 1 : 2;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('The Game is Over !'),
            content: Text('Best Wishes... Player $winner won :)'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text('Play Again'),
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
              'assets/images/dice-$diceNumber.png',
              width: 180,
            ),
          ),
        ),
        const SizedBox(
          height:6.0,
        ),
        Text(
          'Player $currentPlayer',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Orbitron',
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Text(
          'Player 1 Score: $player1Score',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          'Player 2 Score: $player2Score',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Text(
          'Round: $currentRound / 7',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 6.0,
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
