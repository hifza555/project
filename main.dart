Is image ko Flutter ki Dart language mein convert karne ke liye hum `Scaffold`, dark background, status bar aur center mein orange color ke dice icons banayenge. Is design mein dono dice overlapping hain, isliye custom drawing (`CustomPainter`) use karna best rahega.

Neeche complete Dart code hai jo aap `lib/main.dart` mein paste kar sakte hain.

dart
```

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DiceScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class DiceScreen extends StatelessWidget {
  const DiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141212),
      body: SafeArea(
        child: Stack(
          children: [
            // Status bar
            const Positioned(
              top: 12,
              left: 32,
              child: Text(
                '02:00PM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const Positioned(
              top: 10,
              right: 32,
              child: Row(
                children: [
                  Icon(Icons.wifi, color: Colors.white, size: 25),
                  SizedBox(width: 20),
                  Icon(
                    Icons.battery_full,
                    color: Colors.white,
                    size: 27,
                  ),
                ],
              ),
            ),

            // Center dice illustration
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CustomPaint(
                  painter: DicePainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DicePainter extends CustomPainter {
  final Color orange = const Color(0xFFFF9800);

  @override
  void paint(Canvas canvas, Size size) {
    final double scale = size.width / 150;

    canvas.save();
    canvas.scale(scale);

    // Back dice
    drawDice(
      canvas,
      const Rect.fromLTWH(49, 5, 83, 83),
      const [Offset(71, 27), Offset(91, 48), Offset(111, 68)],
    );

    // Front dice
    drawDice(
      canvas,
      const Rect.fromLTWH(0, 59, 83, 83),
      const [
        Offset(22, 81),
        Offset(63, 81),
        Offset(42, 102),
        Offset(22, 122),
        Offset(63, 122),
      ],
    );

    canvas.restore();
  }

  void drawDice(
    Canvas canvas,
    Rect rect,
    List<Offset> dots,
  ) {
    final paint = Paint()
      ..color = orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    // Rounded dice outline
    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(11),
    );

    canvas.drawRRect(rrect, paint);

    // Inner orange edge
    final innerPaint = Paint()
      ..color = const Color(0xFFB87500)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect.deflate(3),
        const Radius.circular(8),
      ),
      innerPaint,
    );

    // Dice dots
    for (final dot in dots) {
      canvas.drawCircle(
        dot,
        8,
        Paint()
          ..color = orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );

      canvas.drawCircle(
        dot,
        4,
        Paint()
          ..color = const Color(0xFFB87500)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      canvas.drawCircle(
        dot,
        1.8,
        Paint()..color = orange,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DicePainter oldDelegate) => false;
}
```

### Code ka result

- Dark black background.
- Screen ke top par time, Wi-Fi aur battery icons.
- Center mein overlapping orange dice.
- Dice ke rounded borders aur circular dots.
- `CustomPainter` se drawing, kisi external package ki zaroorat nahi.

Note: Yeh screenshot ka close recreation hai. System status bar ko bilkul original iPhone jaisa dikhane ke liye device-specific status bar settings bhi configure karni hongi.