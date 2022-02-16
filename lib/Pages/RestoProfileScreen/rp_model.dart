import 'package:mechily/Components/RatersController.dart';
import 'package:get/get.dart';

class RpModel extends GetxController {
  RatersController ratersController = Get.put<RatersController>(
      RatersController(hasRated: false),
      tag: "rpRaters");
  List exclusiveFood = [
    "bananasplit.jpeg",
    "bigburger.jpg",
    "chococupcake.jpg",
  ];
  List daReviews = [
    [
      "Elhadj O. Kane",
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor." +
          " Aenean massa." +
          " Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus." +
          " Donec quam felis, ultricies nec, pellentesque eu, pretium quis,",
      3
    ],
    [
      "Oumar M. Kane",
      "La pizza est une recette de cuisine traditionnelle de la cuisine italienne," +
          " à base de galette de pâte à pain," +
          " garnie de divers mélanges d’ingrédients",
      4
    ],
    [
      "Moussa Dia",
      "La pizza est une recette de cuisine traditionnelle de la cuisine italienne," +
          " à base de galette de pâte à pain," +
          " garnie de divers mélanges d’ingrédients",
      5
    ],
  ];
}
