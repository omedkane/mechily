import 'package:flutter/material.dart';

class StaticRatings extends StatelessWidget {
  final IconData daIcon;
  final Color onColor, offColor;
  final int enabledNb_0;
  final double size, spacing;

  const StaticRatings(
      {Key key,
      this.daIcon,
      this.onColor,
      this.offColor,
      this.enabledNb_0,
      this.size,
      this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          5,
          (index) => Padding(
                padding: EdgeInsets.only(left: (index == 0) ? 0 : spacing ?? 8),
                child: Icon(
                  daIcon ?? Icons.star,
                  size: size ?? 24,
                  color: index < enabledNb_0
                      ? (onColor ?? Colors.white)
                      : (offColor ?? Colors.black87),
                ),
              )),
    );
  }
}
