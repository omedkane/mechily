import 'package:mechily/Models/OneCondiment.dart';
import 'package:flutter/material.dart';

class CondimentGroup {
  // ignore: unused_field
  final String _id;
  final String name;
  final List<Condiment> members;
  final Color color;
  CondimentGroup({
    @required id,
    @required this.name,
    @required this.members,
    @required this.color,
  }) : _id = id;
}
