import 'package:flutter/material.dart';

class InputGroupMember<T> {
  final T ref;
  final TextEditingController controller;
  final FocusNode focusNode = FocusNode(descendantsAreFocusable: false);
  final bool isLast;

  InputGroupMember(this.ref, {this.controller, this.isLast = false})
      : assert(controller != null);
}

class InputGroupController<T> {
  Map<T, InputGroupMember<T>> inputDataMap = {};
  final int inputCount;
  final T lastInputRef;
  final Map<T, String> initialValues;

  InputGroupController(this.inputCount,
      {this.lastInputRef, this.initialValues});

  InputGroupMember<T> setUpInput(T ref) {
    return getMember(ref) ??
        _registerInput(
          ref,
        );
  }

  InputGroupMember<T> _registerInput(T ref) {
    assert(inputDataMap.length != inputCount);

    InputGroupMember<T> inputData = InputGroupMember<T>(
      ref,
      controller: TextEditingController(
        text: initialValues != null ? initialValues[ref] : null,
      ),
      isLast: lastInputRef != null
          ? ref == lastInputRef
          : inputDataMap.length + 1 == inputCount,
    );

    inputDataMap.addAll({ref: inputData});

    return inputData;
  }

  InputGroupMember<T> getMember(T ref) {
    return inputDataMap.containsKey(ref) ? inputDataMap[ref] : null;
  }

  void focusOn(T ref) {
    inputDataMap[ref].focusNode.requestFocus();
  }

  String getInputText(T ref) {
    InputGroupMember<T> targetController = getMember(ref);
    String text = targetController?.controller?.text;
    return text;
  }
}
