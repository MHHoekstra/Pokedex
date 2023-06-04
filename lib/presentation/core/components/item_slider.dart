import 'package:flutter/material.dart';

class ItemSlider extends StatefulWidget {
  final Widget child;
  final bool leftToRight;
  final bool autoShow;
  final bool slide;
  const ItemSlider({
    Key? key,
    required this.child,
    this.leftToRight = true,
    this.autoShow = false,
    this.slide = true,
  }) : super(key: key);

  @override
  State<ItemSlider> createState() => ItemSliderState();
}

class ItemSliderState extends State<ItemSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 1000,
        ));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    if (widget.autoShow) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void show() {
    _controller.forward();
  }

  void hide() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, _) => Transform.translate(
        offset: Offset(
          widget.leftToRight
              ? widget.slide
                  ? -60 * (1 - _animation.value)
                  : 0
              : widget.slide
                  ? 60 * (1 - _animation.value)
                  : 0,
          0,
        ),
        child: Opacity(
          opacity: _animation.value,
          child: widget.child,
        ),
      ),
    );
  }
}
