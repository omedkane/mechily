import 'package:flutter/material.dart';
import 'package:mechily/Models/OneDish.dart';

class Quicky {
  final String id;
  final List<Dish> members;
  final String name;
  final IconData icon;

  const Quicky({this.id, this.members, this.name, this.icon});
}
