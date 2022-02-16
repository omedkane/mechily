import 'package:flutter/material.dart';

class QuickAnimatedSize extends StatefulWidget {
  final Duration duration;
  final Widget child;
  static const defaultDuration = const Duration(milliseconds: 350);
  const QuickAnimatedSize({Key key, this.duration, this.child})
      : super(key: key);
  @override
  _QuickAnimatedSizeState createState() => _QuickAnimatedSizeState();
}

class _QuickAnimatedSizeState extends State<QuickAnimatedSize>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: widget.duration ?? QuickAnimatedSize.defaultDuration,
      vsync: this,
      child: widget.child,
    );
  }
}
