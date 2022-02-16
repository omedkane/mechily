import 'package:mechily/Components/RatersController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OneRater extends StatefulWidget {
  final bool isRated, isRateable;

  final double size;
  final IconData daIcon;
  final Color onColor, offColor;
  final Function onRated, onUnRated;
  final RatersController daController;
  final int myIndex;

  const OneRater({
    Key key,
    this.isRated = false,
    this.size,
    this.daIcon,
    this.onColor,
    this.offColor = Colors.grey,
    this.isRateable = true,
    this.onRated,
    this.onUnRated,
    this.daController,
    this.myIndex,
  }) : super(key: key);
  @override
  _OneRaterState createState() => _OneRaterState();
}

class _OneRaterState extends State<OneRater>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scaler;
  Animation<Color> painter;
  bool isRated, oldIsRated;
  CurvedAnimation daCurve;
  Color onColor;
  int timesBuilt = 0;
  ColorTween painterOn, painterOff;

  @override
  void initState() {
    super.initState();
    isRated = widget.daController.stars[widget.myIndex];
    oldIsRated = isRated;
    onColor = widget.onColor ?? Colors.amber[600];

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    daCurve = CurvedAnimation(
        parent: _controller, curve: Interval(0, 0.5, curve: Curves.linear));

    scaler = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(daCurve);
    // if (oldIsRated)
    painterOn = ColorTween(begin: onColor, end: widget.offColor);
    // else
    painterOff = ColorTween(begin: widget.offColor, end: onColor);
    painter = (oldIsRated ? painterOn : painterOff).animate(daCurve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateMe() {
    if (!_controller.isCompleted)
      _controller.forward();
    else
      _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.daController.stars[widget.myIndex] != isRated) {
      bool rated = widget.daController.stars[widget.myIndex];
      animateMe();
      isRated = rated;
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: scaler.value,
        child: GestureDetector(
            onTap: !widget.isRateable
                ? null
                : () {
                    if (!isRated) {
                      // _controller.forward();
                      // isRated = true;
                      if (widget.onRated != null) widget.onRated();
                    } else {
                      // _controller.reverse();
                      // isRated = false;
                      if (widget.onUnRated != null) widget.onUnRated();
                    }
                  },
            child: Icon(
              widget.daIcon ?? MaterialCommunityIcons.star,
              size: widget.size ?? 24,
              color: painter.value,
            )),
      ),
    );
  }
}
