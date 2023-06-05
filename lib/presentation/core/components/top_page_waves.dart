import 'dart:math';

import 'package:flutter/material.dart';

import 'waves.dart';

class TopPageWaves extends StatefulWidget {
  final Color color;
  final double opacity;
  const TopPageWaves({
    Key? key,
    required this.color,
    this.opacity = 1,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TopPageWavesState();
}

class _TopPageWavesState extends State<TopPageWaves>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -100,
      right: -200,
      child: Transform.rotate(
        angle: -pi * 2 / 3,
        child: Opacity(
          opacity: widget.opacity,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) => Waves(
              animation: _animation,
              color: widget.color,
              height: 300,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
