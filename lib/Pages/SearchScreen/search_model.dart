import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Components/QuickOrderDialog.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Models/OneDish.dart';

class SearchResult<T> {
  final T payload;
  final int score;

  const SearchResult({this.payload, this.score});
}

class SearchScreenModel extends GetxController {
  final Remote<AnimationController> previousHeroSearch;
  final TextEditingController searcher = TextEditingController();
  final List<SearchResult<Dish>> results = [];
  final List<Dish> _dishes = Global.store.dishes.values.toList();
  bool hasSearched = false;

  SearchScreenModel(this.previousHeroSearch);

  @override
  void onClose() {
    previousHeroSearch.object.reverse();
  }

  void searchDish(String text) {
    if (text.trim() == "") return;

    results.clear();
    hasSearched = true;

    final String textLower = text.toLowerCase();

    final void Function(Dish) matcher = (Dish dish) {
      final List<String> splits = textLower.split(" ");
      int score = 0;

      if (dish.name.toLowerCase() == textLower) {
        score = splits.length + 3;
      } else if (dish.name.toLowerCase().contains(text)) {
        score = splits.length + 2;
      } else {
        splits.forEach((daSplit) {
          if (dish.name.toLowerCase().contains(daSplit)) {
            score += 1;
          }
        });
      }

      if (score != 0) {
        SearchResult<Dish> result = SearchResult<Dish>(
          payload: dish,
          score: score,
        );
        if (results.length == 0)
          results.add(result);
        else {
          if (results[results.length - 1].score >= score) {
            results.add(result);
          } else {
            int directSubordinate =
                results.indexWhere((daResult) => score >= daResult.score);

            results.insert(directSubordinate, result);
          }
        }
      }
    };

    _dishes.forEach(matcher);
  }

  void quickOrderDish(Dish dish) {
    AnimatedDialog.show(
      child: QuickOrderDialog(
        dish: dish,
      ),
    );
  }
}
