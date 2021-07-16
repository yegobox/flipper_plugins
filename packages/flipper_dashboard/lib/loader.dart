import 'dart:math';

// import 'package:flipper/utils/HexColor.dart';
import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class LoaderView extends StatefulWidget {
  final double radius;
  final double dotRadius;

  LoaderView({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _LoaderViewState createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView>
    with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  Animation<double>? animation_rotation;
  // ignore: non_constant_identifier_names
  Animation<double>? animation_radius_in;
  // ignore: non_constant_identifier_names
  Animation<double>? animation_radius_out;
  AnimationController? controller;

  double? radius;
  double? dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    animation_rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller!.addListener(() {
      setState(() {
        if (controller!.value >= 0.75 && controller!.value <= 1.0)
          radius = widget.radius * animation_radius_in!.value;
        else if (controller!.value >= 0.0 && controller!.value <= 0.25)
          radius = widget.radius * animation_radius_out!.value;
      });
    });

    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 100.0,
      height: 100.0,
      //color: Colors.black12,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation!,
          child: Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0.0, 0.0),
                    child: Dot(
                      radius: radius,
                      color: HexColor(
                          '#955be9'), //TODO(richard): make inner not rotate so our logo stay in position...
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.amber,
                    ),
                    offset: Offset(
                      radius! * cos(0.0),
                      radius! * sin(0.0),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.deepOrangeAccent,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 1 * pi / 4),
                      radius! * sin(0.0 + 1 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.pinkAccent,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 2 * pi / 4),
                      radius! * sin(0.0 + 2 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.purple,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 3 * pi / 4),
                      radius! * sin(0.0 + 3 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.yellow,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 4 * pi / 4),
                      radius! * sin(0.0 + 4 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.lightGreen,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 5 * pi / 4),
                      radius! * sin(0.0 + 5 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.orangeAccent,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 6 * pi / 4),
                      radius! * sin(0.0 + 6 * pi / 4),
                    ),
                  ),
                  Transform.translate(
                    child: Dot(
                      radius: dotRadius,
                      color: Colors.blueAccent,
                    ),
                    offset: Offset(
                      radius! * cos(0.0 + 7 * pi / 4),
                      radius! * sin(0.0 + 7 * pi / 4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        child: Image.asset('assets/logo.png'),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
