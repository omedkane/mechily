import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  final double size;
  final double iconSize;
  final double sizeScale;
  final List<BoxShadow> boxShadow;
  final Color bgColor;
  final Color splashColor;
  final bool isAsync;
  final String title;
  final TextStyle textStyle;

  MyIconButton(
      {Key key,
      this.iconColor = Colors.black,
      this.icon,
      this.onTap,
      this.size = 48,
      this.bgColor = Colors.white,
      this.splashColor,
      this.iconSize = 24,
      this.boxShadow,
      this.isAsync = false,
      this.sizeScale = 1,
      this.title,
      this.textStyle})
      : super(key: key);
  MyIconButtonState createState() => MyIconButtonState();
}

class MyIconButtonState extends State<MyIconButton> {
  bool isLoading = false;
  switchLoading({bool how}) {
    setState(() {
      isLoading = how ?? !isLoading;
    });
  }

  Future readyGo() async {
    await widget.onTap();
    switchLoading(how: false);
  }

  @override
  Widget build(BuildContext context) {
    var actualWidget = Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, boxShadow: widget.boxShadow ?? null),
      child: ClipOval(
        child: Material(
          color: widget.bgColor,
          child: InkWell(
            splashColor: widget.splashColor,
            child: SizedBox(
              width: widget.size * widget.sizeScale,
              height: widget.size * widget.sizeScale,
              child: isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Icon(
                      widget.icon,
                      size: widget.iconSize * widget.sizeScale,
                      color: widget.iconColor,
                    ),
            ),
            onTap: !widget.isAsync
                ? (widget.onTap ?? () {})
                : () {
                    if (!isLoading) {
                      switchLoading(how: true);
                      readyGo();
                    }
                  },
          ),
        ),
      ),
    );
    if (widget.title == null)
      return actualWidget;
    else
      return Column(
        children: [
          actualWidget,
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: widget.textStyle ?? charcoalText.szA.regfont,
          )
        ],
      );
  }
}
