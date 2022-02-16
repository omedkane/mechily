import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Navigation/FrontPages.dart';
import 'package:flutter/material.dart';

class NavigationPage {
  final PageKey key;
  final FrontPage page;
  final IconData icon;

  NavigationPage({this.key, this.page, this.icon});
}
