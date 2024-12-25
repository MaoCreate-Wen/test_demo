import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RotatingCircles(),
        ),
      ),
    );
  }
}

class RotatingCircles extends StatefulWidget {
  @override
  _RotatingCirclesState createState() => _RotatingCirclesState();
}

class _RotatingCirclesState extends State<RotatingCircles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(5, (index) {
        return AnimatedBuilder(
          animation: _animation,
          child: CircleAvatar(radius: 20),
          builder: (context, child) {
            final angle = _animation.value + (index * 2 * pi / 5);
            final offset = Offset(100 * cos(angle), 100 * sin(angle));
            return Transform.translate(
              offset: offset,
              child: child,
            );
          },
        );
      }),
    );
  }
}