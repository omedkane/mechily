import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class FsCustomPrefDialogController {
  final Function onSubmit;
  final Function onExit;
  String submittedText = "";
  bool hasSubmitted = false;

  FsCustomPrefDialogController({this.onSubmit, this.onExit}) {
    errMsg.value = null;
  }
  TextEditingController textController = TextEditingController();
  RxString errMsg = "".obs;
  RxInt currentTextLength = 0.obs;
  bool validateMe() {
    String datext = textController.text.trim();
    bool response = true;

    if (datext.length > 255) {
      errMsg.value = "Veuillez saisir au plus 255 Caractères";
      response = false;
    } else if (datext.length < 15) {
      errMsg.value = "Veuillez saisir au moins 15 caractères";
      response = false;
    } else
      errMsg.value = null;

    return response;
  }

  void submitMe() {
    String datext = textController.text.trim();
    bool isValid = validateMe();

    if (!isValid) return;

    submittedText = datext;
    hasSubmitted = true;

    onSubmit?.call(submittedText);

    Get.back();

    errMsg.value = null;
  }

  deleteCustomPreference() {
    hasSubmitted = false;
    currentTextLength.value = 0;
    textController.clear();
  }
}

class FsCustomPrefDialog extends StatelessWidget {
  final FsCustomPrefDialogController dialogController;

  const FsCustomPrefDialog({Key key, this.dialogController}) : super(key: key);
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
              Icon(
                MaterialCommunityIcons.food_off,
                color: aoi,
                size: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Préférences",
                  style: aoiText.szB.medfont.apply(fontSizeDelta: 2),
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
                        dialogController.currentTextLength.value.toString() +
                            " / 255",
                        style: (dialogController.currentTextLength.value > 255
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
                    dialogController.currentTextLength.value = value.length;
                  },
                  controller: dialogController.textController,
                  style: blackText.szB.regfontH,
                  decoration: InputDecoration(
                      hintText: "Citez vos préférences et vos allergies ici...",
                      border: InputBorder.none,
                      hintStyle: greyText.szC.medfont),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Obx(() => AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: dialogController.errMsg.value != null
                          ? Text(
                              dialogController.errMsg.value,
                              style: shiroText.szC.medfont,
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              "Précisez les aliments auxquels vous êtes allérgiques !",
                              style: aoiText.szC.regfont,
                              textAlign: TextAlign.center,
                            ),
                    )),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: dialogController.hasSubmitted
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (dialogController.hasSubmitted)
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: GestureDetector(
                  onTap: dialogController.deleteCustomPreference,
                  child: Icon(
                    AntDesign.delete,
                    color: shiro,
                  ),
                ),
              ),
            RadiusButton(
              daColor: aoi,
              title: "Soumettre",
              daTextStyle: whiteText.szB.medfont,
              onTap: () {
                dialogController.submitMe();
              },
            ),
          ],
        )
      ],
    );
  }
}
