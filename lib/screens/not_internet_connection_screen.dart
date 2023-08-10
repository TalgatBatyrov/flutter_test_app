import 'dart:math';

import 'package:flutter/material.dart';

class NotInternetConnectionScreen extends StatefulWidget {
  const NotInternetConnectionScreen({super.key});

  @override
  State<NotInternetConnectionScreen> createState() =>
      _NotInternetConnectionScreenState();
}

class _NotInternetConnectionScreenState
    extends State<NotInternetConnectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.rotate(
          alignment: Alignment.center,
          angle: _animation.value,
          child: Card(
            color: !_controller.isAnimating ? Colors.green[400] : Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'For the best experience, please check your internet connection.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
