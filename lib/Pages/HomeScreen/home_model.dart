import 'package:mechily/Components/QuickyBox.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mechily/Models/OneQuicky.dart';

class HomeCtrl extends GetxController {
  final String quickySectionGetID = "quicky";

  Remote<AnimationController> heroSearchController =
      Remote<AnimationController>();

  List categories = [
    QuickyBox.getHomeCategory(FontAwesome5Solid.pizza_slice, "Pizzas", 0),
    QuickyBox.getHomeCategory(FontAwesome5Solid.coffee, "Café", 1),
    QuickyBox.getHomeCategory(FontAwesome5Solid.cocktail, "Cocktail", 2),
    QuickyBox.getHomeCategory(FontAwesome5Solid.birthday_cake, "Gateaux", 3),
  ];
  List<List<String>> listOfRestaurants = [
    ["rotana.jpg", "Rotana Café", "Ilo K, Tevragh Zeina"],
    ["nkttice2.jpg", "Nouakchott Ice Café", "Tevragh Zeina, Près du Congrés"],
    ["india.jpg", "The India Gate", "Socogim Plage"],
    ["leprince.jpg", "Le Prince", "Ilo Z"],
  ];
  List<Quicky> quickyList = Global.store.quickies.values.toList();
  Quicky selectedQuicky = Global.store.quickySample;

  void setselectedQuicky(Quicky quicky) {
    selectedQuicky = quicky;
    update([quickySectionGetID]);
  }
}
