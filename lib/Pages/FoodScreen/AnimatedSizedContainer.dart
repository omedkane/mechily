import 'package:flutter/material.dart';

class AnimatedSizedContainer extends StatefulWidget {
  final bool isRevealed;

  const AnimatedSizedContainer({Key key, this.isRevealed}) : super(key: key);
  @override
  _AnimatedSizedContainerState createState() => _AnimatedSizedContainerState();
}

class _AnimatedSizedContainerState extends State<AnimatedSizedContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      vsync: this,
      child: !widget.isRevealed
          ? SizedBox()
          : Container(
              child: Text(
                  "lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem" +
                      " lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem"),
            ),
    );
  }
}
