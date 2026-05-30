import 'package:flutter/material.dart';

class AnimationCurves extends StatefulWidget {
  AnimationCurves({super.key});

  @override
  State<AnimationCurves> createState() => _AnimationCurvesState();
}

class _AnimationCurvesState extends State<AnimationCurves> {
  double w = 200.0;

  double h = 200.0;

  double b = 0.0;

  Color colorContainar = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animation Container")),
      body: Container(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                w = 300.0;
                h = 400.0;
                colorContainar = Colors.green;
                b = 100;
                setState(() {});
              },
              child: Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 10),
                  curve: Curves.bounceIn,
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    color: colorContainar,
                    borderRadius: BorderRadius.circular(b),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
