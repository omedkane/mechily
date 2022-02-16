import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedRevealer.dart';
import 'package:mechily/Navigation/NavBarController.dart';
import 'package:mechily/Navigation/NavBarItem.dart';
import 'package:mechily/Navigation/NavigationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarConfiguration {
  final int animationDuration;
  final double navBarItemSize;
  final double navBarSpacing;
  final Color primaryColor = shiro;
  final EdgeInsetsGeometry padding;

  NavBarConfiguration({
    this.navBarItemSize = 56,
    this.navBarSpacing = 8,
    this.animationDuration = 250,
    padding,
  }) : padding = padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 8);
}

class NavBar extends StatelessWidget {
  final NavBarController controller;
  final NavBarConfiguration configuration;

  const NavBar({
    Key key,
    this.controller,
    this.configuration,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      id: "alignment",
      init: controller,
      builder: (_) {
        return Container(
          height:
              configuration.navBarItemSize + configuration.padding.vertical * 2,
          margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Stack(
            children: [
              AnimatedAlign(
                duration:
                    Duration(milliseconds: configuration.animationDuration),
                alignment: controller.navBarAlignment,
                onEnd: () {
                  if (controller.onAligned != null) {
                    controller.onAligned();
                    controller.resetOnAligned();
                  }
                },
                child: Container(
                  padding: configuration.padding,
                  decoration: BoxDecoration(
                    boxShadow: hoverShaded,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GetBuilder<NavBarController>(
                    id: "tabs",
                    builder: (_) {
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            left: controller.tabIndicatorPosition,
                            duration: Duration(
                                milliseconds: configuration.animationDuration),
                            child: Container(
                              height: configuration.navBarItemSize,
                              width: configuration.navBarItemSize,
                              decoration: BoxDecoration(
                                  color: shiro, shape: BoxShape.circle),
                            ),
                          ),
                          Wrap(
                            spacing: configuration.navBarSpacing,
                            children: List.generate(
                              controller.listOfPages.length,
                              (index) {
                                NavigationPage navPage =
                                    controller.listOfPages[index];
                                bool isSelected =
                                    controller.activePage == navPage.key;
                                Color iconColor =
                                    isSelected ? Colors.white : shiro;
                                return NavBarItem(
                                  color: iconColor,
                                  icon: navPage.icon,
                                  isSelected: isSelected,
                                  onTap: () {
                                    controller.onTabTap(navPage.key);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GetBuilder<NavBarController>(
                  id: "revealer",
                  builder: (_) {
                    return AnimatedRevealer(
                      duration: Duration(milliseconds: 300),
                      remote: controller.extraWidgetRevealer,
                      initiallyVisible: false,
                      child: controller.extraWidget,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
