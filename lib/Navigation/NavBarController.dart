import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Navigation/FrontPages.dart';
import 'package:mechily/Navigation/NavBar.dart';
import 'package:mechily/Navigation/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  final List<NavigationPage> listOfPages;
  final NavBarConfiguration navBarConfiguration;
  final double tabIndicatorPositionDelta;
  final void Function(PageKey) onTabTap;
  final AnimatedRevealerController extraWidgetRevealer =
      AnimatedRevealerController();
  final PageKey initialPageKey;

  PageKey activePage;
  double tabIndicatorPosition = 0; // * Offset to the left
  Alignment navBarAlignment = Alignment.bottomCenter;
  Function onAligned;
  Widget extraWidget;

  NavBarController(
    this.listOfPages, {
    @required this.initialPageKey,
    @required this.onTabTap,
    @required this.navBarConfiguration,
  })  : tabIndicatorPositionDelta = navBarConfiguration.navBarItemSize +
            navBarConfiguration.navBarSpacing,
        activePage = initialPageKey;

  void resetOnAligned() {
    onAligned = null;
  }

  void setOnAligned(Function callback) {
    onAligned = callback;
  }

  void setTabIndicatorPosition(int index) {
    double indexDouble = index.toDouble();
    tabIndicatorPosition =
        (index == 0) ? indexDouble : indexDouble * tabIndicatorPositionDelta;
  }

  void setActivePage(PageKey pageKey) {
    activePage = pageKey;
  }

  void turnTabOn(PageKey pageKey, int pageIndex) {
    setTabIndicatorPosition(pageIndex);
    setActivePage(pageKey);
    update(['tabs']);
  }

  void alignNavBarToLeft() {
    navBarAlignment = Alignment.bottomLeft;
    update(['alignment']);
  }

  void alignNavBarToCenter() {
    navBarAlignment = Alignment.bottomCenter;
    update(['alignment']);
  }

  void setExtraWidget(Widget widget) {
    setOnAligned(() {
      extraWidget = widget;
      update(['revealer']);
      extraWidgetRevealer.hide().then((_) {
        if (widget != null) extraWidgetRevealer.show();
      });
    });
    if (widget != null)
      alignNavBarToLeft();
    else
      alignNavBarToCenter();
  }
}
