import 'package:flutter_icons/flutter_icons.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Global/Condiments.dart';
import 'package:mechily/Models/OneCategory.dart';
import 'package:mechily/Models/OneCondimentGroup.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OneQuicky.dart';
import 'package:mechily/Models/OneResto.dart';
import 'package:mechily/Models/OneSubcategory.dart';
import 'package:mechily/Models/OneUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global extends GetxController {
  Global._();
  static final instance = Global._();

  static _Store store = _Store();
  static _Parameters params = _Parameters();
  static _Cache cache = _Cache();
}

// - Parameters

class _Parameters {
  bool _requireAuthBeforeOrder = false;
  bool _passwordPrefered = false;

  final String passwordPreferedGetID = "passpref";
  final String requireAuthGetID = "requireAuth";

  get requireAuthBeforeOrder => _requireAuthBeforeOrder;

  set requireAuthBeforeOrder(value) {
    _requireAuthBeforeOrder = value;
    Global.instance.update([requireAuthGetID]);
  }

  get passwordPrefered => _passwordPrefered;

  set passwordPrefered(value) {
    _passwordPrefered = value;
    Global.instance.update([passwordPreferedGetID]);
  }
  // void
}

// - Cache

class _Cache {
  final Map _cacheMap = {};

  registerCache(key, value) {
    _cacheMap.addAll({key: value});
  }

  getCache(key, value) {
    return _cacheMap[key];
  }

  isRegistered(key) {
    return _cacheMap.containsKey(key);
  }
}

// - Store

class _Store {
  final User currentUser = User(
    firstName: "Henry",
    lastName: "Kane",
    image: "assets/images/subcategories/cakes.jpg",
    permanentAddress: "Socogim PA 20",
    homeDescription: "La maison blanche en face du restaurant malien.",
    phoneNumber: "46480413",
  );
  final Map<String, Dish> dishes = {};

  final Map<String, Quicky> quickies = {
    "pizzas": Quicky(
        icon: FontAwesome5Solid.pizza_slice,
        name: "Pizzas",
        id: "pizzas",
        members: []),
    "coffees": Quicky(
        icon: FontAwesome5Solid.coffee,
        name: "Café",
        id: "coffees",
        members: []),
    "cocktails": Quicky(
        icon: FontAwesome5Solid.cocktail,
        name: "Cocktail",
        id: "cocktails",
        members: []),
    "cakes": Quicky(
        icon: FontAwesome5Solid.birthday_cake,
        name: "Gateaux",
        id: "cakes",
        members: []),
  };
  Dish dishSample;
  Quicky quickySample;
  Category categorySample;
  Subcategory subcategorySample;

  // -> Constructor !
  _Store() {
    categorySample = categories.values.first;
    subcategorySample = subcategories.values.first;

    fetchDishes();
    fetchRestaurants();

    List<Dish> dishesValues = dishes.values.toList();
    quickies['pizzas']?.members?.addAll([
      dishesValues[0],
      dishesValues[1],
      dishesValues[2],
    ]);
    quickies['coffees']?.members?.addAll([
      dishesValues[3],
    ]);
    dishSample = dishesValues.first;
    quickySample = quickies.values.first;

    // - Samples
  }
  // -< Constructor

  // ! Must fetch Restaurants ordered by popularity
  final Map<String, Resto> restaurants = {
    "resto0": Resto("resto0", "Rotana Café", popularity: 9),
    "resto1": Resto("resto1", "Nouakchott Ice", popularity: 8),
    "resto2": Resto("resto2", "Le Prince", popularity: 7),
    "resto3": Resto("resto3", "Restaurant Malien"),
    "resto4": Resto("resto4", "Crusty Burger"),
    "resto5": Resto("resto5", "Domino Pizza"),
    "resto6": Resto("resto6", "L'Indien"),
    "resto7": Resto("resto7", "McDonnald's"),
  };

  final Map<String, CondimentGroup> condimentGroups = {
    'desert0': CondimentGroup(
      color: shiro,
      id: "desert0",
      name: "Déssert",
      members: [
        condiments['nuts'],
        condiments['sugar'],
        condiments['cheese'],
      ],
    ),
    'fastfood0': CondimentGroup(
      color: mustard,
      id: "fastfood0",
      name: "Fast-Food",
      members: [
        condiments['cheese'],
        condiments['onion'],
        condiments['salt'],
        condiments['lettuce'],
        condiments['tomato'],
      ],
    ),
  };

  final Map<String, Category> categories = {
    "cat0": Category(
      "cat0",
      "Fast-Food",
      "assets/images/bigburger.jpg",
      "De la bouffe à bouffer quand vous voulez !",
      Colors.pink,
    ),
    "cat1": Category(
      "cat0",
      "Déssert",
      "assets/images/chococupcake.jpg",
      "De l'après bouffe pour finir en beauté !",
      Colors.pink,
    ),
    "cat2": Category(
      "cat0",
      "Diner",
      "assets/images/compotepomme.jpg",
      "De la bouffe à bouffer la nuit !",
      Colors.indigo,
    ),
  };
  final Map<String, Subcategory> subcategories = {
    "subcat0": Subcategory(
      "subcat0",
      "Sauté",
      "assets/images/subcategories/saute.jpg",
      "De la bouffe à bouffer quand vous voulez !",
      midori,
    ),
    "subcat1": Subcategory(
      "subcat1",
      "Cakes",
      "assets/images/subcategories/cakes.jpg",
      "De l'après bouffe pour finir en beauté !",
      Colors.pink,
    ),
    "subcat2": Subcategory(
      "subcat2",
      "Crêpes",
      "assets/images/subcategories/crepes.jpg",
      "De la bouffe à bouffer la nuit !",
      Colors.purple,
    ),
  };

  List<Resto> topFourPopularRestos = [];
  List<Resto> lessPopularRestos = [];

  void splitRestaurantsByPopularity() {
    if (restaurants.length == 0) return;

    var restaurantsValues = restaurants.values.toList();

    topFourPopularRestos = restaurantsValues.sublist(0, 4);
    lessPopularRestos = restaurantsValues.sublist(4);
  }

  // -> Fetchers !
  void fetchQuickyMembers() {
    List<Dish> dishesValues = dishes.values.toList();
    quickies["quicky0"].members.addAll([
      dishesValues[0],
      dishesValues[1],
      dishesValues[2],
    ]);
  }

  void fetchDishes() {
    // TODO: Fetching Code
    dishes.addAll({
      "dish0": Dish(
        id: "dish0",
        description: "lorem ipsum and shit",
        name: "Pizza Californien",
        price: 654,
        image: "californian-pizza.webp",
        rating: 3,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
      ),
      "dish1": Dish(
        id: "dish1",
        description: "lorem ipsum and shit",
        image: "curstpizza.jpg",
        name: "Pizza Curst",
        price: 130,
        rating: 4,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
        priceMap: {
          "resto1": 456,
          "resto2": 500,
          "resto7": 370,
        },
      ),
      "dish2": Dish(
        id: "dish2",
        description: "lorem ipsum and shit",
        image: "hawaiian-pizza.jpg",
        name: "Pizza Hawaien",
        price: 654,
        rating: 5,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
      ),
      "dish3": Dish(
        id: "dish3",
        description: "lorem ipsum and shit",
        image: "coffeice.jpg",
        name: "Coffee Ice",
        price: 120,
        rating: 5,
        categories: [categorySample],
        priceMap: {
          "resto1": 456,
          "resto2": 500,
          "resto3": 370,
        },
      ),
      "dish4": Dish(
        id: "dish4",
        description: "lorem ipsum and shit",
        image: "compotepomme.jpg",
        name: "Compote de pommes",
        price: 230,
        rating: 5,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
      ),
      "dish5": Dish(
        id: "dish5",
        description: "lorem ipsum and shit",
        image: "sushi.jpg",
        name: "Sushi",
        price: 840,
        rating: 5,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
      ),
      "dish6": Dish(
        id: "dish6",
        description: "lorem ipsum and shit",
        image: "frenchtoast.jpg",
        name: "French Toast",
        price: 542,
        rating: 5,
        categories: [categorySample],
        condimentGroup: condimentGroups['fastfood0'],
      ),
    });
  }

  void fetchRestaurants() {
    // TODO: Fetching Code
    splitRestaurantsByPopularity();
  }

  void fetchPreferences() {}

  // -<
}
