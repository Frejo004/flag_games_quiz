import 'dart:math';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flag_games_quiz/models/countries.dart';
import 'package:flag_games_quiz/screen/score.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  List<Country> countries = [];
  Country? currentCountry;
  List<String> options = [];
  int score = 0;
  bool gameOver = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  Map<String, Color> buttonColors = {};
  late FlipCardController _flipCardController; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _flipCardController = FlipCardController(); 

    fetchCountries().then((fetchedCountries) {
      setState(() {
        countries = fetchedCountries;
        startNewRound();
      });
    });
  }

  void startNewRound() {
    final random = Random();
    currentCountry = countries[random.nextInt(countries.length)];
    options = [currentCountry!.name];
    while (options.length < 4) {
      String option = countries[random.nextInt(countries.length)].name;
      if (!options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();
    buttonColors = { for (var option in options) option : Colors.blue };
    _controller.reset();
    _controller.forward();
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      if (selectedAnswer == currentCountry!.name) {
        buttonColors[selectedAnswer] = Colors.green;
        score++;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            startNewRound();
          });
        });
      } else {
        buttonColors[selectedAnswer] = Colors.red;
        buttonColors[currentCountry!.name] = Colors.green;
        gameOver = true;
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScoreGame(finalScore: score),
            ),
          ).then((_) {
            setState(() {
              score = 0;
              gameOver = false;
              startNewRound();
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'f-d.jpg', 
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Center(
                child: Text(
                  'Qui suis-je ?',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 40),

              Games(
                animation: _animation, 
                flipCardController: _flipCardController, 
                currentCountry: currentCountry
              ),

              SizedBox(height: 40),
              // Afficher la capital
              Column(
                children: [
                  Text(
                    'Indice',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.help_outline, color: Colors.white),
                    iconSize: 40,
                    onPressed: () {
                      _flipCardController.toggleCard(); 
                    },
                  ),
                ],
              ),

              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: options.map((option) {
                    return SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2 - 12,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColors[option],
                        ),
                        onPressed: () => checkAnswer(option),
                        child: Text(
                          option,
                          textAlign: TextAlign.center, 
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


class Games extends StatelessWidget {
  const Games({
    super.key,
    required Animation<double> animation,
    required FlipCardController flipCardController,
    required this.currentCountry,
  }) : _animation = animation, _flipCardController = flipCardController;

  final Animation<double> _animation;
  final FlipCardController _flipCardController;
  final Country? currentCountry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Expanded(
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: FlipCard(
              controller: _flipCardController,
              direction: FlipDirection.HORIZONTAL,
              front: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), 
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), 
                  child: Image.network(
                    currentCountry?.flag ?? '',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              back: SizedBox(
                height: 200,
                child: Card(
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Capital: ${currentCountry?.capital ?? 'No hint available'}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
