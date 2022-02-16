import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IconOptionController {
  bool isEnabled;

  IconOptionController({this.isEnabled = false});
  switchMe() {
    isEnabled = !isEnabled;
  }
}

class AnimatedIconOption extends StatefulWidget {
  final double size;
  final IconData daIcon;
  final Color onColor, offColor;
  final Function onEnabled, onDisabled;
  final IconOptionController daController;

  const AnimatedIconOption({
    Key key,
    this.size,
    this.daIcon,
    this.onColor,
    this.offColor = Colors.black,
    this.onEnabled,
    this.onDisabled,
    this.daController,
  }) : super(key: key);
  @override
  _AnimatedIconOptionState createState() => _AnimatedIconOptionState();
}

class _AnimatedIconOptionState extends State<AnimatedIconOption>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scaler;
  Animation<Color> painter;
  bool iniEnabled;
  CurvedAnimation daCurve;
  Color onColor;
  ColorTween painterOn, painterOff;

  @override
  void initState() {
    super.initState();
    iniEnabled = widget.daController.isEnabled;
    onColor = widget.onColor ?? Colors.white;

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    daCurve = CurvedAnimation(
        parent: _controller, curve: Interval(0, 0.6, curve: Curves.linear));

    scaler = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(daCurve);

    painterOn = ColorTween(begin: onColor, end: widget.offColor);
    painterOff = ColorTween(begin: widget.offColor, end: onColor);

    painter = (iniEnabled ? painterOn : painterOff).animate(daCurve);
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

  void switchMe() {
    animateMe();
    widget.daController.switchMe();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: scaler.value,
        child: GestureDetector(
            onTap: () {
              switchMe();
              if (!widget.daController.isEnabled) {
                if (widget.onEnabled != null) widget.onEnabled();
              } else {
                if (widget.onDisabled != null) widget.onDisabled();
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
