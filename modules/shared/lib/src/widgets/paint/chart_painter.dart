import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class ChartPainter extends CustomPainter {

  final List<String> x;
  final List<double> y;

  final double min, max;

  final double high, low;

  ChartPainter(this.min, this.max, this.x, this.y, this.high, this.low);


  //final Color backGroundColor = Colors.red;
  static double border = 10.0;
  static double radius = 2.0;


  final linePaint = Paint()
    ..color = AppColors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final dotPaintFill = Paint()
    ..color = AppColors.greyBg
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;

  final xLabelStyle = TextStyle(color: Colors.black, fontSize: 12, fontFamily: "SF Pro Text", fontWeight: FontWeight.w500);
  final yLabelStyle = TextStyle(color: AppColors.greyText, fontSize: 12, fontFamily: "SF Pro Text");

  @override
  void paint(Canvas canvas, Size size) {
    /// draw Rect
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);
    canvas.drawPaint(Paint()..color = AppColors.greyBg);

    final drawableHeight =  size.height - 2.0 * border;
    final drawableWidth = size.height - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / this.x.length.toDouble();

    final height = hd * 3.0;
    final width = drawableWidth;

    /// check for invalid values
    if (height <= 0.0 || width <=0.0) return;
    if (max - min < 1.0e-6) return;

    final hr = height / (max - min); //height per unit value

    final left = border;
    final top = border;
    final c = Offset(left + wd/ 2.0, top + height / 2.0);

    final points = _computePoints(c, wd, height, hr);
    final path = _computePath(points);
    final prices = _computePrices();

    /// draw data points and prices
    canvas.drawPath(path, linePaint);
    _drawDataPoints(canvas, points, dotPaintFill);
    _drawPrices(canvas, prices, points, c, wd, top);

    /// draw dates
    final c1 = Offset(c.dx, top + 4 * hd);
    _drawXLabels(canvas, prices, points, c1, wd, top);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _drawXLabels(Canvas canvas, List<String> labels, List<Offset> points, Offset c, double wd, double top) {
    x.forEach((xp) {
      //print(x);
      if (xp == x[0]) {
        drawCenteredText(canvas, c, xp, xLabelStyle, wd);
        c += Offset(wd, 0);
      } else if (xp == x[x.length-1]) {
        drawCenteredText(canvas, c, xp, xLabelStyle, wd);
        c += Offset(wd, 0);
      }
      else {
        c += Offset(wd, 0);
      }
    });
  }

  void _drawPrices(Canvas canvas, List<String> labels, List<Offset> points, Offset c, double wd, double top) {
    var i = 0;
    labels.forEach((label) {
      print(wd);
      if (label == high.toStringAsFixed(1) || label == low.toStringAsFixed(1)) {
        final dp = points[i];
        final dy = (dp.dy - 15) < top ? 15.0 :  -15.0;
        final ly = dp + Offset(0, dy);
        drawCenteredText(canvas, ly, label, yLabelStyle, wd * 35);
      }else {
        c += Offset(wd, 0);
      }
      i++;
    });
  }

  void _drawDataPoints(Canvas canvas, List<Offset> points, Paint dotPaintFill) {
    points.forEach((point) {
      canvas.drawCircle(point, radius, dotPaintFill);
      canvas.drawCircle(point, radius, linePaint);
    });
  }

  TextPainter measureText(String s, TextStyle style, double maxWidth, TextAlign align) {
    final span = TextSpan(text: s , style: style);
    final tp = TextPainter(text: span, textAlign: align, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp;
  }

  Size drawCenteredText(Canvas canvas, Offset c, String text, TextStyle labelStyle, double maxWidth) {
    final tp = measureText(text, labelStyle, maxWidth, TextAlign.center);
    final offset = c + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, offset);

    return tp.size;
  }

  List<String> _computePrices() {
    return y.map((yp) => "${yp.toStringAsFixed(1)}").toList();
  }


  Path _computePath(List<Offset> points) {
    Path path = Path();
    for (var i = 0; i < points.length; i++) {
      final p = points[i];

      if (i ==0 ){
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    return path;
  }

  List<Offset> _computePoints(Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    y.forEach((yp) {
      final yy = (yp - min) * hr;
      final dp = Offset(c.dx, c.dy - height / 2.0 + yy);
      points.add(dp);
      c += Offset(width, 0);
    });

    return points;
  }


  final Paint outlinePaint = Paint()
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..color = Colors.orange;


}