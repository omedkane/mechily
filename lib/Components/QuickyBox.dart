import 'package:mechily/AppStyle.dart';
import 'package:flutter/material.dart';

class QuickyBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final String categoryId;
  final Function onTap;
  final bool isActive;

  static getHomeCategory(icon, title, id) =>
      {'icon': icon, 'title': title, 'id': id};

  const QuickyBox(
      {Key key,
      this.title = "Pizza",
      this.icon = Icons.local_pizza,
      @required this.categoryId,
      this.onTap,
      this.isActive})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: isActive ? shiro : greyish,
                shape: BoxShape.circle,
                boxShadow: gshaded,
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : shiro,
                size: 20,
              ),
            ),
          ),
          if (isActive)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                title,
                style: shiroText.szB.medfont,
              ),
            )
        ],
      ),
    );
  }
}
