import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:flutter/material.dart';

class TextDisplayDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color primaryColor;

  const TextDisplayDialog({
    Key key,
    this.title,
    this.icon,
    this.primaryColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedTitle(
          bgColor: amber,
          daTitle: "Revue",
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 40, left: 16, right: 16),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor." +
                " Aenean massa." +
                " Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus." +
                " Donec quam felis, ultricies nec, pellentesque eu, pretium quis",
            style: blackText.szC.regfontH
                .apply(heightDelta: 0.1, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

void openTextReadingDialog() {
  AnimatedDialog.show(
      child: TextDisplayDialog(
    icon: Icons.star,
    primaryColor: amber,
    title: "Oumar M",
  ));
}
