import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/InputGroupController.dart';
import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final dynamic ref;
  final String hint;
  final bool isEnabled;
  final bool isPassword;
  final bool alternateTheme;
  final InputGroupController groupController;
  final TextEditingController _controller;
  final TextInputType textInputType;
  final Icon icon;
  final void Function() onTap;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  final dynamic nextInputRef;
  final TextInputAction textInputAction;

  static const double height = 60;

  const MyInput({
    Key key,
    this.ref,
    this.hint = "Cherchez ici...",
    this.isPassword = false,
    this.icon,
    this.textInputType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    this.groupController,
    this.alternateTheme = false,
    TextEditingController controller,
    this.nextInputRef,
    this.textInputAction,
    this.onTap,
    this.isEnabled = true,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    InputGroupMember inputMap = groupController?.setUpInput(ref);
    TextEditingController controller = inputMap?.controller ?? _controller;
    FocusNode focusNode = inputMap?.focusNode;
    bool isLastNode = inputMap?.isLast ?? true;
    return Container(
      alignment: Alignment.centerLeft,
      height: height,
      padding: EdgeInsets.only(left: (icon != null) ? 8 : 16),
      decoration: BoxDecoration(
        color: alternateTheme ? Colors.grey[50] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: alternateTheme ? gshaded : null,
      ),
      child: TextField(
        keyboardType: textInputType,
        onEditingComplete: (nextInputRef == null)
            ? null
            : () {
                groupController.focusOn(nextInputRef);
              },
        textInputAction: textInputAction ??
            (isLastNode ? TextInputAction.done : TextInputAction.next),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        enabled: isEnabled,
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword,
        style: blackText.szC.regfont,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: icon,
          alignLabelWithHint: true,
          focusColor: Colors.black,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(minWidth: 36),
          border: InputBorder.none,
          hintStyle: greyText.szC.regfont,
        ),
      ),
    );
  }
}
