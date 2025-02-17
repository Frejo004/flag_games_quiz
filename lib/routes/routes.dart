import 'package:flutter/material.dart';
import 'package:flag_games_quiz/screen/game.dart';
import 'package:flag_games_quiz/screen/home.dart';
import 'package:flag_games_quiz/screen/score.dart';


class Routes {
  final Map<String, WidgetBuilder> _routes = 
    {
      '/game': (context) => const GamePage(),
      '/score': (context) => const ScoreGame(),
      '/': (context) => const Home(),
    };

  Map<String, WidgetBuilder> getRoutes() {
    return _routes;
  }
}