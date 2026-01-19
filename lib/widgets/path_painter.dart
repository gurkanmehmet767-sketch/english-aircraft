import 'package:flutter/material.dart';

/// Custom painter for drawing curved paths between lesson nodes
/// Creates Duolingo-style flowing path connections with glow effects
class PathPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final bool isLocked;
  final double progress;

  PathPainter({
    required this.startPoint,
    required this.endPoint,
    required this.color,
    this.isLocked = false,
    this.progress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _createPath();
    
    if (isLocked) {
      _drawLockedPath(canvas, path);
    } else {
      _drawUnlockedPath(canvas, path);
    }
  }

  void _drawUnlockedPath(Canvas canvas, Path path) {
    // Simple 2-layer approach for CONSISTENT brightness
    // No overlapping layers = no curve accumulation issues
    
    // Layer 1: Main path - solid color
    canvas.drawPath(path, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color);
    
    // Layer 2: Center highlight for 3D effect
    canvas.drawPath(path, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white.withValues(alpha: 0.35));
  }

  void _drawLockedPath(Canvas canvas, Path path) {
    // Outer glow (dimmer)
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawPath(path, glowPaint);
    
    // Main path (dimmer)
    final mainPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = color.withValues(alpha: 0.55);
    canvas.drawPath(path, mainPaint);
    
    // Inner highlight
    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.white.withValues(alpha: 0.2);
    canvas.drawPath(path, highlightPaint);
  }

  Path _createPath() {
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);

    final deltaX = endPoint.dx - startPoint.dx;
    final deltaY = endPoint.dy - startPoint.dy;
    
    // Nearly vertical - just draw straight line
    if (deltaX.abs() < 30) {
      path.lineTo(endPoint.dx, endPoint.dy);
    } else {
      // Smooth S-curve using cubic bezier - much smoother than L-shaped
      // Control points create a natural flowing curve
      final controlPoint1 = Offset(startPoint.dx, startPoint.dy + deltaY * 0.5);
      final controlPoint2 = Offset(endPoint.dx, startPoint.dy + deltaY * 0.5);
      
      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        endPoint.dx, endPoint.dy,
      );
    }

    return path;
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) {
    return oldDelegate.startPoint != startPoint ||
        oldDelegate.endPoint != endPoint ||
        oldDelegate.color != color ||
        oldDelegate.isLocked != isLocked ||
        oldDelegate.progress != progress;
  }
}

