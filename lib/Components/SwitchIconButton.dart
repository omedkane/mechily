import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchIconButtonModel extends GetxController {}

class SwitchIconButton extends StatefulWidget {
  final double size;
  final Color boxColorWhenOn,
      boxColorWhenOff,
      iconColorWhenOn,
      iconColorWhenOff;
  final IconData iconWhenOn, iconWhenOff;
  final bool Function() switchStateGetter;
  final Function enabler, disabler;
  final BoxShape shape;

  SwitchIconButton({
    Key key,
    this.shape = BoxShape.circle,
    this.size = 48,
    this.boxColorWhenOn = shiro,
    this.boxColorWhenOff = Colors.white,
    @required this.iconWhenOn,
    @required this.iconWhenOff,
    this.enabler,
    this.disabler,
    @required this.switchStateGetter,
  })  : iconColorWhenOff = boxColorWhenOn,
        iconColorWhenOn = boxColorWhenOff,
        super(key: key);

  @override
  _SwitchIconButtonState createState() => _SwitchIconButtonState();
}

class _SwitchIconButtonState extends State<SwitchIconButton> {
  bool _isLoading = false;
  bool isEnabled;

  @override
  void initState() {
    isEnabled = widget.switchStateGetter();
    super.initState();
  }

  set isLoading(value) {
    setState(() {
      _isLoading = value;
    });
  }

  void switchMe() async {
    if (_isLoading) return;

    isLoading = true;

    if (isEnabled)
      await widget.disabler?.call();
    else
      await widget.enabler?.call();

    isEnabled = widget.switchStateGetter();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: switchMe,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: widget.size,
        width: widget.size,
        alignment: Alignment.center,
        decoration: widget.shape == BoxShape.circle
            ? BoxDecoration(
                boxShadow: gshaded,
                color: isEnabled ? widget.boxColorWhenOn : Colors.white,
                shape: widget.shape,
              )
            : BoxDecoration(
                boxShadow: gshaded,
                color: isEnabled ? widget.boxColorWhenOn : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
        child: !_isLoading
            ? Icon(
                isEnabled ? widget.iconWhenOn : widget.iconWhenOff,
                color: isEnabled
                    ? widget.iconColorWhenOn
                    : widget.iconColorWhenOff,
                size: 24,
              )
            : SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  backgroundColor: widget.boxColorWhenOn,
                ),
              ),
      ),
    );
  }
}
