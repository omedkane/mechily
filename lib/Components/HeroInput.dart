import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Misc/functions.dart';

class HeroInput extends StatefulWidget {
  final bool animateOnReady;
  final Remote<AnimationController> remote;
  final void Function() callback;
  final Widget input;

  const HeroInput({
    Key key,
    this.animateOnReady = false,
    this.callback,
    this.remote,
    this.input,
  }) : super(key: key);
  @override
  _HeroInputState createState() => _HeroInputState();
}

class _HeroInputState extends State<HeroInput>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool inputVanished = false;
  Animation<double> inputOpacity;
  Animation<double> containerWidth;
  Animation<double> containerBRadius;

  @override
  void initState() {
    super.initState();
    const Duration duration = const Duration(milliseconds: 500);

    _controller = AnimationController(vsync: this, duration: duration);

    double inputWidth = MediaQuery.of(Get.context).size.width - 32;
    bool reversed = widget.animateOnReady;

    inputOpacity = getAnimation<double>(
      1.0,
      0,
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.3),
      ),
      reverse: reversed,
    );

    CurvedAnimation containerCurve = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, duration.inMilliseconds / 1000),
    );

    // print("in reverse: "+ containerCurve.);

    containerWidth = getAnimation<double>(
      inputWidth,
      MyInput.height,
      containerCurve,
      reverse: reversed,
    );

    containerBRadius = getAnimation<double>(
      12.0,
      MyInput.height / 2,
      containerCurve,
      reverse: reversed,
    );

    if (reversed)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        animateMe();
      });

    if (widget.remote != null) {
      widget.remote.object = _controller;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateMe() async {
    if (_controller.isAnimating) return;

    await _controller.forward();
    if (widget.callback != null) {
      widget.callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animateMe();
      },
      child: SizedBox(
        height: MyInput.height,
        child: Stack(
          children: [
            Hero(
              tag: "search",
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => Container(
                  height: MyInput.height,
                  width: containerWidth.value,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(containerBRadius.value),
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: inputOpacity,
              child: widget.input,
            ),
          ],
        ),
      ),
    );
  }
}
