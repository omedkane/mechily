import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Models/OneCondiment.dart';
import 'package:mechily/mechily_icons.dart';

Map<String, Condiment> condiments = {
  'lettuce': Condiment(
    id: 'lettuce',
    name: "Salades",
    icon: CondimentsIcons.lettuce,
    color: Colors.green,
  ),
  'onion': Condiment(
    id: 'onion',
    name: "Oinions",
    icon: CondimentsIcons.onion,
    color: Colors.purple,
  ),
  'salt': Condiment(
    id: 'salt',
    name: "Sel",
    icon: CondimentsIcons.salt,
    color: amber,
  ),
  'peper': Condiment(
    id: 'peper',
    name: "Poivre",
    icon: CondimentsIcons.salt,
    color: Colors.brown[800],
  ),
  'cheese': Condiment(
    id: 'cheese',
    name: "Fromage",
    icon: CondimentsIcons.cheese,
    color: amber,
  ),
  'sugar': Condiment(
    id: 'sugar',
    name: "Sucre",
    icon: CondimentsIcons.sugar,
    color: Colors.pink,
  ),
  'tomato': Condiment(
    id: 'tomato',
    name: "Tomato",
    icon: CondimentsIcons.tomato,
    color: Colors.red,
  ),
  'nuts': Condiment(
    id: 'nuts',
    name: "Noix",
    icon: CondimentsIcons.nuts,
    color: Colors.orange[800],
  ),
  'almond': Condiment(
    id: 'almond',
    name: "Muscade",
    icon: CondimentsIcons.nutmeg,
    color: Colors.white,
  ),
  'ketchup': Condiment(
    id: 'ketchup',
    name: "Ketchup",
    icon: CondimentsIcons.tomato,
    color: shiro,
  ),
  'mayonnaise': Condiment(
    id: 'mayonnaise',
    name: "Mayonnaise",
    icon: CondimentsIcons.tomato,
    color: Colors.orange,
  ),
  'mustard': Condiment(
    id: 'mustard',
    name: "Moutarde",
    icon: CondimentsIcons.tomato,
    color: mustard,
  ),
};
