import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class RadiusButtonAsync extends StatefulWidget {
  final Color daColor;
  final String title;
  final bool rightAligned;
  final double daRadius;

  final Widget child;
  final EdgeInsetsGeometry padding;

  final Function onTap;
  final TextStyle daTextStyle;

  final double width, height;

  const RadiusButtonAsync(
      {Key key,
      this.daColor,
      this.title,
      this.onTap,
      this.daTextStyle,
      this.rightAligned = false,
      this.daRadius = 16.0,
      this.child,
      this.padding,
      this.width,
      this.height})
      : super(key: key);
  @override
  _RadiusButtonAsyncState createState() => _RadiusButtonAsyncState();
}

class _RadiusButtonAsyncState extends State<RadiusButtonAsync> {
  bool isSynching = false, isSuccessful = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Material(
        color: widget.daColor,
        clipBehavior: Clip.hardEdge,
        borderRadius: widget.rightAligned
            ? BorderRadius.only(
                bottomLeft: Radius.circular(widget.daRadius),
                topRight: Radius.circular(widget.daRadius))
            : BorderRadius.only(
                bottomRight: Radius.circular(widget.daRadius),
                topLeft: Radius.circular(widget.daRadius)),
        child: InkWell(
          splashColor: Colors.white,
          onTap: isSynching
              ? () {}
              : () async {
                  // bool localSuccess;
                  if (this.mounted)
                    setState(() {
                      isSynching = true;
                    });
                  await Future.value(widget.onTap()).then((value) {
                    // print(value);
                    if (value is bool) {
                      // localSuccess = value;
                      if (this.mounted)
                        setState(() {
                          isSuccessful = value;
                        });
                    }
                  });
                  Future.delayed(Duration(seconds: 2), () {
                    if (this.mounted)
                      setState(() {
                        isSynching = false;
                      });
                  });
                },
          child: Container(
            height: 56,
            width: widget.width,
            alignment: widget.width == null ? null : Alignment.center,
            padding: widget.padding ??
                EdgeInsets.symmetric(horizontal: widget.width == null ? 16 : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSynching
                    ? isSuccessful
                        ? Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          )
                        : SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          )
                    : widget.child ??
                        Text(
                          widget.title,
                          style: widget.daTextStyle ?? whiteText.szB.medfont,
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
