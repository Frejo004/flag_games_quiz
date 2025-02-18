import 'package:flutter/material.dart';
import 'dart:math';

class ScoreGame extends StatefulWidget {
  final int finalScore;

  ScoreGame({required this.finalScore});

  @override
  _ScoreGameState createState() => _ScoreGameState();
}

class _ScoreGameState extends State<ScoreGame> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scoreAnimation;
  late Animation<double> _starsAnimation;

  @override
  void initState() {
    super.initState();

    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );


    _scoreAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _starsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

 
  List<Offset> _generateStarPositions() {
    final random = Random();
    List<Offset> positions = [];
    for (int i = 0; i < 10; i++) {
      positions.add(Offset(
        random.nextDouble() * MediaQuery.of(context).size.width,
        random.nextDouble() * MediaQuery.of(context).size.height,
      ));
    }
    return positions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Score'),
      ),
      body: FadeTransition(
        opacity: _scoreAnimation, 
        child: Stack(
          children: [
            
            AnimatedBuilder(
              animation: _starsAnimation,
              builder: (context, child) {
                List<Offset> starPositions = _generateStarPositions();
                return CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  painter: StarPainter(starPositions, _starsAnimation.value),
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ScaleTransition(
                    scale: _scoreAnimation, 
                    child: Text(
                      'Votre score final est: ${widget.finalScore}',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Jouer encore'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter for drawing stars
class StarPainter extends CustomPainter {
  final List<Offset> starPositions;
  final double animationValue;

  StarPainter(this.starPositions, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    for (var position in starPositions) {
      double starSize = 10 + 5 * animationValue;
      canvas.drawCircle(Offset(position.dx, position.dy - 20 * animationValue), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
