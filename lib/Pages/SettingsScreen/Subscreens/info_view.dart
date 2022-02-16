import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mechily/Components/FormInput.dart';
import 'package:mechily/Components/MyButton.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Components/MyTextArea.dart';
import 'package:mechily/Components/Notice.dart';
import 'package:mechily/Components/ScreenTitle.dart';
import 'package:mechily/Components/SwitchIconButton.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/info_model.dart';
import 'package:flutter/material.dart';
import 'package:mechily/AppStyle.dart';

class InformationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<InformationSettingsModel>(
            init: InformationSettingsModel(),
            builder: (model) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: AppPaddings.screen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ScreenTitle(title: "Renseignements"),
                        Center(
                          child: Obx(
                            () => Notice(
                              text: model.notice.value,
                              type: model.noticeType,
                            ),
                          ),
                        ),
                        GetBuilder<InformationSettingsModel>(
                          id: model.addressGetID,
                          builder: (model) {
                            return FormInput(
                              widget: MyInput(
                                alternateTheme: true,
                                ref: InfoForm.address,
                                hint: "Saisir votre adresse ici...",
                                groupController: model.groupController,
                              ),
                              isRequired:
                                  model.locationAvailable ? false : true,
                              title: "Adresse",
                              trailingWidgetTitle: Text(
                                model.locationAvailable
                                    ? "Position Enregistré"
                                    : "Localisez-moi",
                                style: shiroText.szB.medfont,
                              ),
                              trailingWidget: SwitchIconButton(
                                switchStateGetter: () =>
                                    model.locationAvailable,
                                iconWhenOff:
                                    MaterialCommunityIcons.map_marker_outline,
                                iconWhenOn: MaterialCommunityIcons.map_marker,
                                size: MyInput.height,
                                shape: BoxShape.rectangle,
                                boxColorWhenOn: shiro,
                                enabler: () async {
                                  model.position =
                                      await SimplePosition.getCurrentPosition();
                                  if (model.position == null) {
                                    print("infoview: location is null");
                                    return false;
                                  }
                                  print(
                                    '''
                                  longitude : ${model.position.longitude}
                                  latitude : ${model.position.latitude}
                                  altitude : ${model.position.altitude}
                                  ''',
                                  );

                                  model.update([model.addressGetID]);
                                },
                                disabler: () {
                                  model.position = null;

                                  model.update([model.addressGetID]);
                                },
                              ),
                            );
                          },
                        ),
                        FormInput(
                          widget: MyInput(
                            alternateTheme: true,
                            ref: InfoForm.phone,
                            groupController: model.groupController,
                            hint: "Saisir votre numéro ici...",
                            textInputType: TextInputType.phone,
                          ),
                          title: "Numéro de téléphone",
                          leadingWidget: Text(
                            "(+222) ",
                            style: greyText.szC.boldfont,
                          ),
                        ),
                        FormInput(
                          widget: MyTextArea(
                            ref: InfoForm.homeDescription,
                            groupController: model.groupController,
                            hint:
                                "Veuillez décrire votre domicile et ses environs",
                          ),
                          title: "Description du domicile",
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: MyButton(
                            onTap: () {
                              model.submit();
                            },
                            title: "Enregister",
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
