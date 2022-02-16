import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class AnimatedTopTabBar<T> extends StatefulWidget {
  final List<String> titles;
  final bool invertedColor;
  final void Function(T) onTabChanged;
  final int initialPageIndex;
  final T initialPageKey;
  final Alignment alignment;
  final bool isFrozen;
  final Map<String, T> tabMap;
  final bool isMap;

  const AnimatedTopTabBar({
    Key key,
    this.titles,
    this.invertedColor = false,
    this.onTabChanged,
    this.initialPageIndex = 0,
    this.alignment,
    this.isFrozen = false,
    this.tabMap,
    this.initialPageKey,
  })  : assert(!(initialPageKey != null && tabMap == null)),
        isMap = tabMap != null,
        super(key: key);

  @override
  _AnimatedTopTabBarState<T> createState() => _AnimatedTopTabBarState<T>();
}

class _AnimatedTopTabBarState<T> extends State<AnimatedTopTabBar> {
  List<GlobalKey> daKeys = [];
  double focusBoxWidth = 30.0;
  double focusBoxHeight = 30.0;
  double focusBoxPos = 0.0;
  int currentPageIndex;
  List<Widget> tabList = [];

  @override
  void initState() {
    super.initState();
    int initialPage;
    if (widget.initialPageKey == null)
      initialPage = widget.initialPageIndex;
    else
      initialPage = associateToIndex(widget.initialPageKey);
    currentPageIndex = initialPage;

    int tabCount = widget.isMap ? widget.tabMap.length : widget.titles.length;

    daKeys.addAll(List.generate(tabCount, (_) => GlobalKey()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      goTo(initialPage);
    });
  }

  int associateToIndex(T associate) {
    assert(associate != null);
    int index = widget.tabMap.values.toList().indexOf(associate);
    return index != -1 ? index : null;
  }

  void goTo(int index) {
    if (widget.isFrozen) return;

    focusBoxWidth = daKeys[index].currentContext.size.width;
    focusBoxHeight = daKeys[index].currentContext.size.height;
    double newPos = 0.0;
    for (var i = 0; i < index; i++) {
      newPos += daKeys[i].currentContext.size.width + 10.0;
    }
    focusBoxPos = newPos;

    setState(() {
      currentPageIndex = index;
    });
  }

  void setUpTabs() {
    if (widget.isMap) {
      tabList = [];
      int count = 0;

      widget.tabMap.forEach((title, associate) {
        var index = count;
        GlobalKey key = daKeys[index];

        tabList.add(
          GestureDetector(
            onTap: () {
              widget.onTabChanged?.call(associate);
              goTo(index);
            },
            child: TabBarItem(
              isColorInverted: widget.invertedColor,
              key: key,
              title: title,
              isSelected: index == currentPageIndex,
            ),
          ),
        );
        count++;
      });
    } else {
      tabList = List.generate(
        widget.titles.length,
        (index) {
          String title = widget.titles[index];
          GlobalKey key = daKeys[index];
          return GestureDetector(
            onTap: () {
              widget.onTabChanged?.call(index);
              goTo(index);
            },
            child: TabBarItem(
              isColorInverted: widget.invertedColor,
              key: key,
              title: title,
              isSelected: index == currentPageIndex,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setUpTabs();
    return Align(
      alignment: widget.alignment,
      child: Stack(
        children: [
          AnimatedPositioned(
            left: focusBoxPos,
            duration: Duration(milliseconds: 300),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: focusBoxWidth,
              height: focusBoxHeight,
              decoration: widget.invertedColor
                  ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: shiro, width: 1),
                    )
                  : BoxDecoration(
                      color: shiro,
                      borderRadius: BorderRadius.circular(16),
                    ),
            ),
          ),
          Wrap(spacing: 10, children: tabList)
        ],
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  final String title;
  final bool isColorInverted;
  final bool isSelected;

  const TabBarItem({
    Key key,
    this.title,
    this.isColorInverted = true,
    this.isSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: ((!isColorInverted && isSelected) ? whiteText : shiroText)
            .szC
            .medfont,
      ),
    );
  }
}
