import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/OneRater.dart';
import 'package:mechily/Components/RatersController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Raters extends StatefulWidget {
  final RatersController daController;
  final double size;
  final IconData daIcon;
  final Color onColor, offColor;
  final bool showRatingComment;
  final bool fillWidth;
  const Raters({
    Key key,
    @required this.daController,
    this.size = 40,
    this.daIcon,
    this.onColor,
    this.offColor,
    this.showRatingComment = false,
    this.fillWidth = true,
  }) : super(key: key);
  @override
  _RatersState createState() => _RatersState();
}

class _RatersState extends State<Raters> {
  static List ratings = [
    'Pas Terrible',
    "Mangeable",
    "Assez-Bien",
    "Bien",
    "Zeyn Hateu !"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<RatersController>(
        id: "raters",
        builder: (_) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize:
                    widget.fillWidth ? MainAxisSize.max : MainAxisSize.min,
                children: List.generate(
                  widget.daController.starsNb,
                  (index) => OneRater(
                    daIcon: widget.daIcon,
                    onColor: widget.onColor,
                    offColor: widget.offColor,
                    size: widget.size,
                    myIndex: index,
                    isRated: widget.daController.stars[index],
                    daController: widget.daController,
                    onRated: () {
                      widget.daController.enableToNb(index);
                    },
                    onUnRated: () {
                      widget.daController.disableFromNb(index);
                    },
                  ),
                ),
              ),
              if (widget.showRatingComment)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    ratings[widget.daController.enabledNb_0],
                    style: blackText.extSzD.medfont
                        .apply(color: widget.onColor ?? Colors.amber[700]),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
