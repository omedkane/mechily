import 'package:mechily/Models/OneCategory.dart';
import 'package:mechily/Models/OneCondimentGroup.dart';
import 'package:mechily/Models/OneReview.dart';
import 'package:mechily/Models/OneSubcategory.dart';

class Dish {
  final String id;
  final String name;
  final String description;
  int _price;
  final String image;
  final double rating;
  final List<Category> categories;
  final List<Subcategory> subcategories;
  final CondimentGroup condimentGroup;
  final List<Review> reviews;
  final Map<String, int> _priceMap;

  Dish({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rating,
    this.condimentGroup,
    int price,
    Map<String, int> priceMap,
    List<Category> categories,
    List<Subcategory> subcategories,
    List<Review> reviews,
  })  : categories = categories ?? [],
        subcategories = subcategories ?? [],
        reviews = reviews ?? [],
        _price = price,
        _priceMap = priceMap {
    // ->
    if (_price == null && _priceMap != null) {
      _price = getAveragePrice();
    }
    // -<
  }

  int getAveragePrice() {
    int count = 0;
    double __price = 0;
    _priceMap.forEach((key, value) {
      __price += value ?? 0;
      count++;
    });
    int avgPrice = __price ~/ count;
    return avgPrice;
  }

  int getPriceFrom(String restaurantId) =>
      _priceMap == null ? null : _priceMap[restaurantId];

  get price => _price;

  static Map generateMap({
    name,
    description,
    price,
    image,
    rating,
    categories,
    subcategories,
    condimentGroup,
    reviews,
    priceMap,
  }) =>
      {
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "rating": rating,
        "categories": categories,
        "subcategories": subcategories,
        "condimentGroup": condimentGroup,
        "reviews": reviews,
        "priceMap": priceMap,
      };
}
