import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Components/MyTextArea.dart';
import 'package:mechily/Components/RadiusButton.dart';
import 'package:mechily/Components/RoundedTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final String notice;
  final Color primaryColor;
  final String initialText;
  final TextEditingController textEditingController;
  final String textInputHint;
  final RxInt currentTextLength;
  final RxString errorMsg = RxString(null);
  final bool isTextArea;
  final dynamic Function(String) validator;
  final void Function(String) onSubmit;
  final int maxTextLength, minTextLength;
  final String submitButtonTitle;
  final Icon submitButtonIcon;
  final TextStyleSet primaryTextStyleSet;

  CustomInputDialog({
    Key key,
    @required this.title,
    this.icon,
    this.notice,
    this.primaryColor = aoi,
    @required this.textInputHint,
    this.initialText,
    this.validator,
    this.onSubmit,
    this.isTextArea = true,
    this.maxTextLength = 255,
    this.minTextLength = 5,
    this.submitButtonTitle = "Soumettre",
    this.submitButtonIcon,
  })  : textEditingController = TextEditingController(text: initialText),
        currentTextLength = RxInt(initialText?.length ?? 0),
        primaryTextStyleSet = TextStyleSet(primaryColor),
        super(key: key);

  bool lengthValidation(String text) {
    if (text.length < minTextLength) {
      errorMsg.value =
          "Vous avez peu saisie (au moin $minTextLength caractères)";
      return false;
    } else if (text.length > maxTextLength) {
      errorMsg.value =
          "Vous avez trop saisie (au plus $maxTextLength caractères)";
      return false;
    }
    return true;
  }

  bool isTextValid(String text) {
    if (!lengthValidation(text)) return false;

    if (validator == null) return true;

    var testResult = validator(text);

    if (testResult is bool && testResult) {
      errorMsg.value = null;
      return true;
    } else if (testResult is String) {
      errorMsg.value = testResult;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedTitle(
          bgColor: primaryColor.withOpacity(0.1),
          daWidget: Row(
            children: [
              Icon(icon, color: primaryColor),
              const SizedBox(width: 8),
              Text(title, style: primaryTextStyleSet.extSzB.semfont)
            ],
          ),
          daTitle: title,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Obx(() => Text(
                        currentTextLength.value.toString() +
                            " / $maxTextLength",
                        style: (currentTextLength.value > maxTextLength
                                ? shiroText
                                : greyText)
                            .szA
                            .medfont,
                      )),
                ),
              ),
              !isTextArea
                  ? Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: MyInput(
                        hint: textInputHint,
                        controller: textEditingController,
                        onChanged: (value) {
                          currentTextLength.value = value.length;
                        },
                      ),
                    )
                  : MyTextArea(
                      controller: textEditingController,
                      hint: textInputHint,
                      onChanged: (value) {
                        currentTextLength.value = value.length;
                      },
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Obx(() => AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: errorMsg.value != null
                          ? Text(
                              errorMsg.value,
                              style: shiroText.szC.medfont,
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              notice,
                              style: primaryTextStyleSet.szB.regfont
                                  .apply(fontSizeDelta: 1),
                              textAlign: TextAlign.center,
                            ),
                    )),
              )
            ],
          ),
        ),
        RadiusButton(
          daColor: primaryColor,
          title: "Soumettre",
          daTextStyle: whiteText.szB.medfont,
          child: submitButtonIcon,
          onTap: () {
            String text = textEditingController.text;

            if (isTextValid(text)) {
              onSubmit?.call(text);
              Get.back();
            }
          },
        )
      ],
    );
  }
}
