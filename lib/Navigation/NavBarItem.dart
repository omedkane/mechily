import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final Color color;
  final Function onTap;
  final double size;

  const NavBarItem(
      {Key key,
      this.isSelected,
      this.icon,
      this.color,
      this.onTap,
      this.size = 56})
      : super(key: key);
  Widget build(BuildContext context) {
    Color iconColor = isSelected ? Colors.white : color;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: size,
        width: size,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
