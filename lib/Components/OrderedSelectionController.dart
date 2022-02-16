import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Misc/classes.dart';

class OrderedSelectionMember<T> {
  final Widget Function(Color bgColor, TextStyleSet textStyleSet) extraWidget1;
  final Widget Function(Color bgColor, TextStyleSet textStyleSet) extraWidget2;
  final void Function(dynamic) onEnabled, onDisabled;

  final OrderedSelectionController controller;
  final T payload;
  int rank = 0;
  final String title;
  bool isSelected = false;
  String id;
  int index;

  OrderedSelectionMember({
    this.controller,
    this.title,
    this.payload,
    this.isSelected,
    this.extraWidget1,
    this.extraWidget2,
    this.onEnabled,
    this.onDisabled,
  }) {
    index = controller.registerItem(this);
  }

  void selectMe() {
    controller.selectItem(index);
  }

  void unselectMe() {
    controller.unselectItem(index);
  }

  void switchMe() {
    if (isSelected)
      unselectMe();
    else
      selectMe();
  }
}

class OrderedSelectionController<T> extends Connect2Component {
  final List<OrderedSelectionMember<T>> _listOfOptions = [];
  final void Function(OrderedSelectionMember) onSelection;
  final void Function(OrderedSelectionMember) onUnselection;
  final void Function() onEmptySelection;

  OrderedSelectionController({
    this.onSelection,
    this.onUnselection,
    this.onEmptySelection,
    listOfTriggers,
  }) : super(listOfTriggers);

  int registerItem(OrderedSelectionMember<T> item) {
    item.id = _listOfOptions.length.toString();
    _listOfOptions.add(item);
    return _listOfOptions.length - 1;
  }

  get isEmpty => getGreastestChoice() == 0;

  void selectItem(int itemIndex) {
    OrderedSelectionMember item = _listOfOptions[itemIndex];
    item.rank = getGreastestChoice() + 1;
    item.isSelected = true;

    updateComponents();

    onSelection?.call(item);
    item.onEnabled?.call(item.payload);
  }

  void unselectItem(int itemIndex) {
    OrderedSelectionMember item = _listOfOptions[itemIndex];

    fixChoicesOrder(item.rank);
    item.rank = 0;
    item.isSelected = false;

    updateComponents();

    onUnselection?.call(item);
    item.onDisabled?.call(item.payload);

    if (isEmpty) {
      onEmptySelection?.call();
    }
  }

  bool isItemSelected(int itemIndex) => _listOfOptions[itemIndex].isSelected;

  List<OrderedSelectionMember<T>> getListOrderedByRank() {
    List<OrderedSelectionMember<T>> optionListCopy = [..._listOfOptions];
    optionListCopy.sort((a, b) {
      int rankA = a.rank;
      int rankB = b.rank;
      if (rankA > rankB)
        return 1;
      else if (rankA == rankB)
        return 0;
      else
        return -1;
    });
    return optionListCopy;
  }

  List<OrderedSelectionMember<T>> getSelectedMembers() {
    List<OrderedSelectionMember<T>> selectedMembers = [];

    _listOfOptions.forEach((member) {
      if (member.isSelected) selectedMembers.add(member);
    });

    return selectedMembers;
  }

  void disableAllSelections() {
    for (var i = 0; i < _listOfOptions.length; i++) {
      _listOfOptions[i].isSelected = false;
      _listOfOptions[i].rank = 0;
    }
    onEmptySelection?.call();
    updateComponents();
  }

  int getGreastestChoice() {
    int daGreatest = 0;
    _listOfOptions.forEach((element) {
      if (element.rank > daGreatest) {
        daGreatest = element.rank;
      }
    });
    return daGreatest;
  }

  void fixChoicesOrder(int disruptNb) {
    int nbFixed = 0;
    int daGreatest = 0;
    for (var i = 0; i < _listOfOptions.length; i++) {
      if (_listOfOptions[i].rank > daGreatest)
        daGreatest = _listOfOptions[i].rank;

      if (_listOfOptions[i].rank > disruptNb) {
        _listOfOptions[i].rank--;
        nbFixed++;
      }
    }

    if (nbFixed > 0) updateComponents();
  }
}
