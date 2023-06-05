import 'dart:math';

import 'package:flutter/material.dart';

import 'waves.dart';

class BottomPageWaves extends StatefulWidget {
  final Color color;
  final double opacity;
  const BottomPageWaves({
    Key? key,
    required this.color,
    this.opacity = 1,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomPageWavesState();
}

class _BottomPageWavesState extends State<BottomPageWaves>
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
      bottom: -100,
      left: -200,
      child: Transform.rotate(
        angle: pi / 3,
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
