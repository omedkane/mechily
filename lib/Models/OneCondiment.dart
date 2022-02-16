import 'package:flutter/material.dart';

class Condiment {
  // ignore: unused_field
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  Condiment({
    @required this.id,
    @required this.name,
    @required this.icon,
    this.color,
  });
}
