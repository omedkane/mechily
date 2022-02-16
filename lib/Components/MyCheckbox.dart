import 'package:flutter/material.dart';

import '../AppStyle.dart';

class MyCheckbox extends StatelessWidget {
  static double size = 12;
  final bool isEnabled;
  final double sizeScale;

  const MyCheckbox({
    Key key,
    @required this.isEnabled,
    this.sizeScale = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const duration = const Duration(milliseconds: 200);
    return AnimatedContainer(
      duration: duration,
      alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(4 * sizeScale),
      width: 34,
      decoration: BoxDecoration(
        border: Border.all(
            color: isEnabled ? shiro : Colors.grey.shade500,
            width: 1 * sizeScale),
        borderRadius: BorderRadius.circular(8) * sizeScale,
      ),
      child: AnimatedContainer(
        duration: duration,
        height: size * sizeScale,
        width: size * sizeScale,
        decoration: BoxDecoration(
          color: isEnabled ? shiro : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(4 * sizeScale),
        ),
      ),
    );
  }
}
