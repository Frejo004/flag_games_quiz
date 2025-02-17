import 'package:animations/animations.dart';
import 'package:flag_games_quiz/screen/game.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🎮🧭🌍🌏🌎',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Flags Quiz',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onPrimaryFixedVariant),
            ),
            ElevatedButton(
              onPressed: () {
                 Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const GamePage();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        child: child, 
                      ); 
                    },
                  ),);
              },
            child: Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}