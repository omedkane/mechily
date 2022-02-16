import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';
import 'package:get/get.dart';

class AnimatedDialog extends StatefulWidget {
  final double height;
  final Widget child;

  final double width;

  const AnimatedDialog({
    Key key,
    this.height,
    this.width,
    this.child,
  }) : super(key: key);
  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();

  static Future<void> show({Widget child, double widthFactor}) async {
    double screenWidth = MediaQuery.of(Get.context).size.width;
    await showDialog(
      context: Get.context,
      barrierColor: Colors.black26,
      builder: (context) => Center(
        child: AnimatedDialog(
          width: screenWidth * (widthFactor ?? WidthFactors.dialog),
          child: child,
        ),
      ),
    );
  }
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scaler;
  Animation<double> daRadius;
  CurvedAnimation daCurve;

  CurvedAnimation daCurve2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    daCurve = CurvedAnimation(
        parent: _controller, curve: Interval(0, 0.6, curve: Curves.linear));
    daCurve2 = CurvedAnimation(
        parent: _controller, curve: Interval(0.2, 0.4, curve: Curves.linear));
    scaler = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 25),
    ]).animate(daCurve);
    daRadius = Tween<double>(begin: 150.0, end: 16.0).animate(daCurve2);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: scaler.value,
            child: Material(
              elevation: 32,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(daRadius.value),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: widget.height,
                width: widget.width ?? screenWidth * WidthFactors.dialog,
                child: widget.child,
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
