import 'package:flutter/material.dart';

class Waves extends StatelessWidget {
  const Waves({
    super.key,
    required this.animation,
    required this.height,
    required this.width,
    this.color = Colors.lightBlue,
  });
  final Color color;
  final Animation animation;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.bottomLeft,
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _WavePainter(
                waveHeight: 3,
                waveLength: 40,
                color: color.withOpacity(0.4),
                borderColor: Colors.white38,
                animationPercentage: animation.value,
              ),
            ),
            CustomPaint(
              painter: _WavePainter(
                waveHeight: 5,
                waveLength: 60,
                color: color.withOpacity(0.7),
                borderColor: Colors.white54,
                animationPercentage: animation.value,
              ),
            ),
            CustomPaint(
              painter: _WavePainter(
                waveHeight: 10,
                waveLength: 80,
                color: color,
                borderColor: Colors.white70,
                animationPercentage: animation.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double waveHeight;
  final double waveLength;
  final Color color;
  final Color borderColor;
  final double animationPercentage;
  const _WavePainter({
    required this.waveHeight,
    required this.waveLength,
    required this.color,
    required this.animationPercentage,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, waveHeight);
    double currentPosition = 0.0 - (waveLength * 2) * animationPercentage;
    bool up = true;
    while (currentPosition <= size.width) {
      if (up) {
        path.quadraticBezierTo(currentPosition + waveLength / 2, 0,
            currentPosition + waveLength, waveHeight);
      } else {
        path.quadraticBezierTo(currentPosition + waveLength / 2, waveHeight * 2,
            currentPosition + waveLength, waveHeight);
      }
      up = !up;
      currentPosition += waveLength;
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0 - waveLength * 2, size.height);
    path.close();

    Paint strokePaint = Paint()
      ..color = borderColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);
    Paint fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
