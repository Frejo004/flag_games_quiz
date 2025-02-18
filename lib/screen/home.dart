import 'package:animations/animations.dart';
import 'package:flag_games_quiz/screen/game.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, 
        children: [
          Image.asset(
            '/countries.png',
            fit: BoxFit.cover,
          ),
          // Your existing widgets
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '🎮',
                  style: Theme.of(context).textTheme.displayLarge,
                  selectionColor: Colors.white,
                ),
                Text(
                  'Flags Quiz',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                ),
                SizedBox(height: 35,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const GamePage();
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeThroughTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            child: child,
                          ); 
                        },
                      ),
                    );
                  },
                  child: Text('Jouer une partie'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
