import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // الخلفية المتدرجة
    Paint backgroundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        [const Color(0xff226579), const Color(0xFF908b92)],
      );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // رسم منحنى مقوس في أسفل الشاشة
    Path curvePath = Path();
    curvePath.moveTo(0, size.height * 0.8); // بدء المسار من أسفل اليسار
    curvePath.quadraticBezierTo(
      size.width * 0.5, // النقطة الوسطى
      size.height, // الارتفاع
      size.width, // النقطة النهائية
      size.height * 0.8, // ارتفاع نهاية المنحنى
    );
    curvePath.lineTo(size.width, size.height); // إغلاق المسار يمينًا
    curvePath.lineTo(0, size.height); // إغلاق المسار يسارًا
    curvePath.close();

    Paint curvePaint = Paint()..color = Colors.white;
    canvas.drawPath(curvePath, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
