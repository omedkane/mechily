import 'package:mechily/Navigation/NavigationPage.dart';
import 'package:mechily/Pages/BasketScreen/basket_view.dart';
import 'package:mechily/Pages/FavouritesScreen/favourites_view.dart';
import 'package:mechily/Pages/HomeScreen/home_view.dart';
import 'package:mechily/Pages/SettingsScreen/settings_view.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum PageKey { home, basket, favourites, settings }

List<NavigationPage> frontPages = [
  NavigationPage(
      key: PageKey.home, icon: MaterialCommunityIcons.home, page: HomeScreen()),
  NavigationPage(
      key: PageKey.basket,
      icon: MaterialCommunityIcons.basket,
      page: BasketScreenBuilder()),
  NavigationPage(
      key: PageKey.favourites,
      icon: MaterialCommunityIcons.star,
      page: FavouritesScreen()),
  NavigationPage(
      key: PageKey.settings,
      icon: MaterialCommunityIcons.settings,
      page: SettingsScreen()),
];
