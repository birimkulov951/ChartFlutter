import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class PaintWrapper extends StatefulWidget {

  final List<ChartPoints> scores;
  final double high, low;

  const PaintWrapper({Key key, this.scores, this.high, this.low}) : super(key: key);

  @override
  _PaintWrapperState createState() => _PaintWrapperState();
}


class _PaintWrapperState extends State<PaintWrapper> {

  double _min, _max;

  List<double> _Y;
  List<String> _X;



  @override
  void initState() {
    super.initState();

    var min = double.maxFinite;
    var max = -double.maxFinite;
    widget.scores.forEach((p) {
      min = min > p.value ? p.value : min;
      max = max < p.value ? p.value : max;
    });

    setState(() {
      _min = min;
      _max = max;

      _Y = widget.scores.map((p) => p.value).toList();
      _X = widget.scores
          .map((p) => "${p.time.day}/${p.time.month}")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: CustomPaint(
          child: Container(),
          painter: ChartPainter(_min, _max, _X, _Y, widget.high, widget.low)
      ),
    );
  }
}



