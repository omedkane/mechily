import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Navigation/FrontPages.dart';
import 'package:mechily/Navigation/NavBar.dart';
import 'package:mechily/Navigation/NavBarController.dart';
import 'package:mechily/Navigation/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNavigatorController extends GetxController {
  final List<NavigationPage> listOfPages;
  final Map<PageKey, int> pageKeyIndexes = {};
  final Map<int, PageKey> indexPageKeys = {};
  final PageController pageController = PageController();
  final NavBarConfiguration navBarConfiguration;
  NavBarController navBarController;

  PageNavigatorController(this.listOfPages, {this.navBarConfiguration}) {
    int count = 0;
    listOfPages.forEach(
      (navPage) {
        pageKeyIndexes.addAll({navPage.key: count});
        indexPageKeys.addAll({count: navPage.key});
        count++;
      },
    );

    navBarController = NavBarController(
      listOfPages,
      navBarConfiguration: navBarConfiguration,
      onTabTap: navigateTo,
      initialPageKey: indexPageKeys[0],
    );
  }

  int getPageIndex(PageKey pageKey) {
    return pageKeyIndexes[pageKey];
  }

  PageKey getPageKey(int pageIndex) {
    return indexPageKeys[pageIndex];
  }

  void navigateTo(PageKey pageKey) {
    int pageIndex = getPageIndex(pageKey);

    pageController.jumpToPage(pageIndex);

    // onPageChanged(pageIndex);
  }

  void turnTabOn({PageKey pageKey, int pageIndex}) {
    int daPageIndex = pageIndex ?? getPageIndex(pageKey);
    PageKey daPageKey = pageKey ?? getPageKey(pageIndex);

    navBarController.turnTabOn(daPageKey, daPageIndex);
  }

  void setPageExtraWidget(int pageIndex) {
    FrontPage page = listOfPages[pageIndex].page;

    navBarController.setExtraWidget(page.extraWidget);
  }

  void onPageChanged(int pageIndex) {
    turnTabOn(pageIndex: pageIndex);
    setPageExtraWidget(pageIndex);
  }
}

class PageNavigator extends StatelessWidget {
  final PageNavigatorController controller;

  PageNavigator({
    Key key,
    List<NavigationPage> listOfPages,
    NavBarConfiguration navBarConfiguration,
  })  : controller = Get.put<PageNavigatorController>(
          PageNavigatorController(
            listOfPages,
            navBarConfiguration: navBarConfiguration,
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: NavBar(
        controller: controller.navBarController,
        configuration: controller.navBarConfiguration,
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onPageChanged(index);
        },
        children: List.generate(
          frontPages.length,
          (index) {
            return controller.listOfPages[index].page as Widget;
          },
        ),
      ),
    );
  }
}
