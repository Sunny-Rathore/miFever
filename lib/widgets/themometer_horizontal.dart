import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

class ThermoTestHorizontal extends StatefulWidget {
  final double value;

  const ThermoTestHorizontal({Key? key, required this.value}) : super(key: key);
  @override
  State<ThermoTestHorizontal> createState() => _ThermoTestHorizontal();
}

class _ThermoTestHorizontal extends State<ThermoTestHorizontal> {
  @override
  Widget build(BuildContext context) {
    return ThermoHorizontal(
      duration: const Duration(milliseconds: 1250),
      color: appTheme.redA200,
      value: widget.value,
      curve: Curves.easeInOut,
    );
  }
}

class ThermoHorizontal extends ImplicitlyAnimatedWidget {
  const ThermoHorizontal({
    Key? key,
    Curve curve = Curves.linear,
    required this.color,
    required this.value,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Color color;
  final double value;

  @override
  AnimatedWidgetBaseState<ThermoHorizontal> createState() =>
      _ThermoHorizontalState();
}

class _ThermoHorizontalState extends AnimatedWidgetBaseState<ThermoHorizontal> {
  ColorTween? _color;
  Tween<double>? _value;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        child: CustomPaint(
          size: const Size(50, 150),
          painter: _ThermoPainterHorizontal(
            color: _color!.evaluate(animation)!,
            value: _value!.evaluate(animation),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color, (dynamic v) => ColorTween(begin: v))
        as ColorTween?;
    _value =
        visitor(_value, widget.value, (dynamic v) => Tween<double>(begin: v))
            as Tween<double>?;
  }
}

class _ThermoPainterHorizontal extends CustomPainter {
  _ThermoPainterHorizontal({
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    const bulbRadius = 7.0;
    const smallRadius = 3.0;
    const border = 2.5;
    final rect = (Offset.zero & size);
    final innerRect = rect.deflate(size.width / 2 - bulbRadius);
    final r1 = Alignment.bottomCenter
        .inscribe(const Size(2 * smallRadius, bulbRadius * 2), innerRect);
    final r2 = Alignment.center
        .inscribe(Size(2 * smallRadius, innerRect.height), innerRect);

    final bulb = Path()
      ..addOval(Alignment.bottomCenter
          .inscribe(Size.square(innerRect.width), innerRect));

    final bulb1 = Path()
      ..addOval(Alignment.bottomCenter
          .inscribe(Size.square(innerRect.width), innerRect));

    final outerPath = Path()
      ..addOval(Alignment.bottomCenter
          .inscribe(Size.square(innerRect.width), innerRect)
          .inflate(border))
      ..addRRect(RRect.fromRectAndRadius(r2, const Radius.circular(smallRadius))
          .inflate(border));

    final scaleRect = Rect.fromPoints(innerRect.topLeft,
        innerRect.bottomRight - const Offset(0, 2 * bulbRadius));
    Iterable<Offset> generatePoints() sync* {
      for (int i = 0; i < 11; i++) {
        final t = i / 11;
        final point =
            Offset.lerp(scaleRect.bottomRight, scaleRect.topRight, t)!;
        yield point;
        yield point.translate(2, 0);
      }
    }

    final valueRect = Rect.lerp(r1, r2, value)!;
    final valuePaint = Paint()..color = color;
    final valueRect1 = Rect.lerp(r1, r2, 1.0)!;
    final valuePaint1 = Paint()..color = appTheme.red50;

    canvas
      ..save()
      ..rotate(1.57)
      ..translate(-75, -440)
      ..scale(6)
      // draw scale
      ..drawPoints(
          PointMode.lines,
          generatePoints().toList(),
          Paint()
            ..color = appTheme.redA200
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.2)

      // draw Border
      ..drawPath(outerPath.shift(const Offset(0.3, 0)),
          Paint()..color = appTheme.redA200)
      ..drawPath(outerPath.shift(const Offset(0, 0.3)),
          Paint()..color = appTheme.redA200)
      ..drawPath(outerPath.shift(const Offset(-0.3, 0)),
          Paint()..color = appTheme.redA200)
      ..drawPath(outerPath.shift(const Offset(0, -0.3)),
          Paint()..color = appTheme.redA200)
      ..clipPath(outerPath)

      // draw background
      ..drawPaint(Paint()..color = Color.alphaBlend(Colors.white, color))
      ..drawPath(bulb1, valuePaint1)
      ..drawRRect(RRect.fromRectAndRadius(valueRect1, const Radius.circular(3)),
          valuePaint1)

      // draw foreground
      ..drawPath(bulb, valuePaint)
      ..drawRRect(
          RRect.fromRectAndRadius(
              valueRect, const Radius.circular(smallRadius)),
          valuePaint)
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
