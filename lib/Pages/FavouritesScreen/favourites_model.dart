import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Components/QuickOrderDialog.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OnePreset.dart';
import 'package:mechily/Pages/BasketScreen/DetailsDialogModel.dart';
import 'package:mechily/Pages/BasketScreen/OrderDetailsDialog.dart';
import 'package:get/get.dart';

class FavouritesScreenModel extends GetxController {
  final String favouritesSectionGetID = "favourites";
  final String presetsSectionGetID = "presets";
  void orderDish(int index) {
    Dish dish = Global.store.currentUser.favouriteDishes[index];
    AnimatedDialog.show(
      child: QuickOrderDialog(
        dish: dish,
        indexOfFavourite: index,
        listUpdatingCallback: () {
          update([favouritesSectionGetID]);
        },
      ),
    );
  }

  void showPresetDetails(int index) {
    Preset preset = Global.store.currentUser.presets[index];
    DetailsDialogModel detailsDialogModel = DetailsDialogModel(preset.toOrder(),
        preset: preset, presetIndex: index, listUpdatingCallback: () {
      update([presetsSectionGetID]);
    });
    AnimatedDialog.show(
      child: OrderDetailsDialog(
        model: detailsDialogModel,
      ),
    );
  }
}
