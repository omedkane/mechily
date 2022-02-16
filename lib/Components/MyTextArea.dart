import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:mechily/Components/InputGroupController.dart';

class MyTextArea extends StatelessWidget {
  final dynamic ref;
  final double height, width;
  final String hint;
  final void Function(String) onChanged, onSubmitted;
  final InputGroupController groupController;
  final TextEditingController _controller;
  final dynamic nextInputRef;

  const MyTextArea({
    Key key,
    this.height = 150,
    this.width,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.ref,
    this.groupController,
    TextEditingController controller,
    this.nextInputRef,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    InputGroupMember inputMap = groupController?.setUpInput(ref);
    TextEditingController controller = inputMap?.controller ?? _controller;
    FocusNode focusNode = inputMap?.focusNode;
    bool isLast = inputMap?.isLast ?? true;

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          boxShadow: gshaded),
      child: TextField(
        expands: true,
        maxLines: null,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: (nextInputRef == null)
            ? null
            : () {
                groupController.focusOn(nextInputRef);
              },
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        style: blackText.szC.regfontH,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: greyText.szC.regfont),
      ),
    );
  }
}
