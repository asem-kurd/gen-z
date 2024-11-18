import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // خلفية متدرجة
    Paint backgroundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.9, 0),
        Offset(size.width * 0.5, size.height),
        [
          const Color(0xff01B7C5),
          const Color(0xff782C96),
        ],
      );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // دائرة كبيرة متجاوبة تبدأ من الزاوية العلوية اليمنى
    Paint circlePaint = Paint()..color = const Color(0xff37394C);
    double circleRadius =
        size.width * 2.1; // اجعل نصف القطر يتناسب مع عرض الشاشة
    canvas.drawOval(
      Rect.fromCircle(
        center: Offset(size.width * 1.2,
            -circleRadius * 0.26), // ضبط الموقع بناءً على أبعاد الشاشة
        radius: circleRadius,
      ),
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
