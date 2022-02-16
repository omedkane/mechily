import 'package:get/get.dart';

class HeroSearchController extends GetxController {
  final String inputGetID = "input";
  final bool initiallyVanished;

  bool _inputRemoved = false;
  bool _inputVanished = false;

  HeroSearchController({this.initiallyVanished = false})
      : _inputRemoved = initiallyVanished,
        _inputVanished = initiallyVanished;

  get inputRemoved => _inputRemoved;

  set inputRemoved(val) {
    _inputRemoved = val;
    update();
  }

  get inputVanished => _inputVanished;

  set inputVanished(val) {
    _inputVanished = val;
    update();
  }
}
