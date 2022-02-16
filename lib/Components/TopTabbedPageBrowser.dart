import 'package:mechily/Components/AnimatedTopTabBar.dart';
import 'package:flutter/material.dart';

class TabPage {
  final String title;
  final Widget page;

  TabPage(this.title, this.page);
}

class TopTabbedPageBrowser extends StatefulWidget {
  final List<TabPage> tabPages;
  final int initialPageIndex;
  final Alignment tabBarAlignment;
  final Duration duration;

  TopTabbedPageBrowser({
    Key key,
    this.tabPages,
    this.initialPageIndex = 0,
    duration,
    this.tabBarAlignment = Alignment.topLeft,
  })  : duration = duration ?? Duration(milliseconds: 400),
        super(key: key);
  @override
  _TopTabbedPageBrowserState createState() => _TopTabbedPageBrowserState();
}

class _TopTabbedPageBrowserState extends State<TopTabbedPageBrowser>
    with TickerProviderStateMixin {
  AnimationController _controller;
  List<Widget> pages = [];
  List<String> titles = [];
  int currentPageIndex;
  Animation<double> fadeIn, fadeOut;
  Animation<double> slideInFromRight, slideOutToLeft;
  Animation<double> slideInFromLeft, slideOutToRight;
  bool isNavigatingForth = true;
  CurvedAnimation curve;
  // CurvedAnimation curveIn;
  bool hasPageFaded = false;

  @override
  void initState() {
    super.initState();
    widget.tabPages.forEach((tabPage) {
      pages.add(tabPage.page);
      titles.add(tabPage.title);
    });

    currentPageIndex = widget.initialPageIndex;

    _controller = AnimationController(vsync: this, duration: widget.duration);
    curve = CurvedAnimation(
        parent: _controller,
        curve: Interval(0, widget.duration.inMilliseconds / 1000,
            curve: Curves.linear));

    fadeIn = Tween<double>(begin: 0, end: 1).animate(curve);
    fadeOut = Tween<double>(begin: 1, end: 0).animate(curve);

    slideOutToLeft = Tween<double>(begin: 0, end: -100).animate(curve);
    slideInFromRight = Tween<double>(begin: 100, end: 0).animate(curve);

    slideOutToRight = Tween<double>(begin: 0, end: 100).animate(curve);
    slideInFromLeft = Tween<double>(begin: -100, end: 0).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> animateTo(int index) async {
    if (_controller.isAnimating || (index == currentPageIndex)) return;

    setState(() {
      isNavigatingForth = index > currentPageIndex;
    });

    await _controller.forward();
    setState(() {
      hasPageFaded = true;
      currentPageIndex = index;
    });
    _controller.reset();

    await _controller.forward();
    setState(() {
      hasPageFaded = false;
    });
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: AnimatedTopTabBar(
              alignment: widget.tabBarAlignment,
              titles: titles,
              onTabChanged: (tabIndex) {
                animateTo(tabIndex);
              },
              initialPageIndex: widget.initialPageIndex,
              isFrozen: _controller.isAnimating,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Flexible(
            child: AnimatedBuilder(
              animation: _controller,
              child: pages[currentPageIndex],
              builder: (context, child) {
                return FadeTransition(
                  opacity: hasPageFaded ? fadeIn : fadeOut,
                  child: Transform.translate(
                    offset: Offset(
                      isNavigatingForth
                          ? (!hasPageFaded
                              ? slideOutToLeft.value
                              : slideInFromRight.value)
                          : (!hasPageFaded
                              ? slideOutToRight.value
                              : slideInFromLeft.value),
                      0,
                    ),
                    child: child,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
