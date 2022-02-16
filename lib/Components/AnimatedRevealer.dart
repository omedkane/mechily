import 'package:mechily/Misc/classes.dart';
import 'package:flutter/material.dart';

class AnimatedRevealer extends StatefulWidget {
  final bool initiallyVisible;
  final Widget child;
  final Duration duration;
  final AnimatedRevealerController remote;

  const AnimatedRevealer({
    Key key,
    this.initiallyVisible = true,
    this.child,
    @required this.duration,
    this.remote,
  }) : super(key: key);
  @override
  _AnimatedRevealerState createState() => _AnimatedRevealerState(duration);
}

class _AnimatedRevealerState extends State<AnimatedRevealer>
    with TickerProviderStateMixin {
  final Duration duration;
  AnimationController _controller;
  bool spaceShrank;
  bool isVisible;
  Animation<double> scaleIn;
  Animation<double> fadeIn;
  Animation<double> scaleOut;
  Animation<double> fadeOut;
  CurvedAnimation curve;

  _AnimatedRevealerState(this.duration);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);

    isVisible = widget.initiallyVisible;
    spaceShrank = !isVisible;

    curve = CurvedAnimation(
        parent: _controller,
        curve: Interval(0, widget.duration.inMilliseconds / 1000,
            curve: Curves.linear));

    // * Animations Out -->
    scaleOut = TweenSequence(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.3), weight: 60),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.3, end: 0.0), weight: 40),
      ],
    ).animate(curve);
    fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(curve);
    // * -->

    // * Animations In -->
    scaleIn = TweenSequence(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 1.3), weight: 40),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.3, end: 1.0), weight: 60),
      ],
    ).animate(curve);
    fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(curve);
    // * -->

    widget.remote
        .setUp(initiallyVisible: isVisible, show: showWidget, hide: hideWidget);
  }

  Future<void> showWidget() async {
    setState(() {
      spaceShrank = false;
    });
    await Future.delayed(
      Duration(milliseconds: duration.inMilliseconds + 10),
      () async {
        await _controller.forward();
        setState(() {
          isVisible = true;
        });
        _controller.reset();
      },
    );
  }

  Future<void> hideWidget() async {
    await _controller.forward().then((_) {
      setState(() {
        spaceShrank = true;
        isVisible = false;
      });
      _controller.reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: duration,
      child: spaceShrank
          ? SizedBox()
          : AnimatedBuilder(
              animation: _controller,
              child: widget.child,
              builder: (context, child) {
                return Opacity(
                  opacity: isVisible ? fadeOut.value : fadeIn.value,
                  child: Transform.scale(
                    scale: isVisible ? scaleOut.value : scaleIn.value,
                    child: widget.child,
                  ),
                );
              },
            ),
    );
  }
}
