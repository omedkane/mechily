import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/RadiusButtonAsync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class CommentDialogController {
  CommentDialogController() {
    errMsg.value = null;
  }
  TextEditingController textController = TextEditingController();
  RxString errMsg = "".obs;
  bool hasCommented = false;
  RxInt currentTextLength = 0.obs;

  Future commentMe() async {
    String datext = textController.text;
    if (datext.length > 255) {
      errMsg.value = "Votre commentaire est trop long ! (> 255 Caractères)";
      hasCommented = false;

      return false;
    } else if (datext.length < 15) {
      errMsg.value = "Votre commentaire est trop court ! (< 15 Caractères)";
      hasCommented = false;

      return false;
    } else {
      // TODO: Actual Comment Code
      errMsg.value = null;
      hasCommented = true;
      return true;
    }
  }
}

class FsCommentDialog extends StatelessWidget {
  final CommentDialogController daController;
  final int enabledNb_0;

  const FsCommentDialog(
      {Key key, this.daController, @required this.enabledNb_0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 30,
                          color: Colors.amber.shade300,
                          spreadRadius: 10)
                    ], shape: BoxShape.circle),
                  ),
                  Icon(
                    AntDesign.star,
                    color: Colors.amber.shade600,
                    size: 48,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  enabledNb_0.toString() +
                      " Étoile" +
                      (enabledNb_0 > 1 ? "s" : ""),
                  style: mustardText.szB.medfont.apply(fontSizeDelta: 2),
                ),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Obx(() => Text(
                        daController.currentTextLength.value.toString() +
                            " / 255",
                        style: (daController.currentTextLength.value > 255
                                ? shiroText
                                : greyText)
                            .szA
                            .medfont,
                      )),
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: gshaded),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  onChanged: (value) {
                    daController.currentTextLength.value = value.length;
                  },
                  controller: daController.textController,
                  style: blackText.szB.regfontH,
                  decoration: InputDecoration(
                      hintText: "Saisir votre revue ici...",
                      border: InputBorder.none,
                      hintStyle: greyText.szC.medfont),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Obx(() => daController.errMsg.value != null
                      ? Text(
                          daController.errMsg.value,
                          style: shiroText.szC.medfont,
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "Votre revue ne sera visible qu'au restaurateur !",
                          style: mustardText.szC.regfont,
                          textAlign: TextAlign.center,
                        )),
                ),
              )
            ],
          ),
        ),
        RadiusButtonAsync(
          daColor: amber,
          title: "Soumettre",
          daTextStyle: whiteText.szB.medfont,
          onTap: () async {
            daController.commentMe().then((val) {
              if (!val)
                print(daController.errMsg.value);
              else {
                print("You did it");
                Navigator.pop(context);
              }
            });
          },
        )
      ],
    );
  }
}
