import 'package:flutter/material.dart';
import 'package:flag_games_quiz/screen/game.dart';
import 'package:flag_games_quiz/screen/home.dart';


class Routes {
  final Map<String, WidgetBuilder> _routes = 
    {
      '/game': (context) => const GamePage(),
      '/': (context) => const Home(),
    };

  Map<String, WidgetBuilder> getRoutes() {
    return _routes;
  }
}