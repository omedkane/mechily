import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/MyButton.dart';
import 'package:mechily/Components/MyCheckbox.dart';
import 'package:mechily/Components/MyInput.dart';
import 'package:mechily/Components/Notice.dart';
import 'package:mechily/Components/ScreenTitle.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Pages/SettingsScreen/SettingTile.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/security_model.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SecurityScreenModel>(
      init: SecurityScreenModel(),
      builder: (model) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppPaddings.screen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTitle(
                        title: "Sécurité",
                      ),
                      const SizedBox(height: Spaces.titleToWidget),
                    ],
                  ),
                ),
                GetBuilder<Global>(
                  id: Global.params.requireAuthGetID,
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SettingTile(
                          colorInverted: true,
                          icon: MaterialCommunityIcons.fingerprint,
                          title: "Authentification avant la commande",
                          subtitle:
                              "Éxiger l'authentification avant chaque commande",
                          extraWidget: MyCheckbox(
                            isEnabled: Global.params.requireAuthBeforeOrder,
                          ),
                          onTap: () {
                            Global.params.requireAuthBeforeOrder =
                                !Global.params.requireAuthBeforeOrder;
                          },
                        ),
                        const SizedBox(height: 24),
                        GetBuilder<Global>(
                          id: Global.params.passwordPreferedGetID,
                          builder: (_) {
                            return Column(
                              children: [
                                SettingTile(
                                  colorInverted: true,
                                  isDisabled:
                                      !Global.params.requireAuthBeforeOrder,
                                  icon: MaterialCommunityIcons.textbox_password,
                                  title: "Mot de passe plutôt",
                                  subtitle:
                                      "Préferer un mot de passe plutôt que l'empreinte ou le FaceID",
                                  extraWidget: MyCheckbox(
                                    isEnabled:
                                        Global.params.requireAuthBeforeOrder &&
                                            Global.params.passwordPrefered,
                                  ),
                                  onTap: () {
                                    Global.params.passwordPrefered =
                                        !Global.params.passwordPrefered;
                                  },
                                  onDisabledTap: () {
                                    Alert.alert(
                                      "Veuillez exiger l'authentification en activant l'option en-dessus !",
                                      type: AlertType.info,
                                    );
                                  },
                                ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: !Global.params.passwordPrefered ||
                                          !Global.params.requireAuthBeforeOrder
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 24, right: 24, top: 38),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Obx(
                                                  () => Notice(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 24),
                                                    text: model.notice.value,
                                                    type: model.noticeType,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Mot de passe :",
                                                style: blackText.szC.regfont,
                                              ),
                                              const SizedBox(height: 16),
                                              MyInput(
                                                hint:
                                                    "Saisir votre mot de passe ici...",
                                                isPassword: true,
                                                alternateTheme: true,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onSubmitted: (_) {
                                                  print("waa");
                                                },
                                                controller:
                                                    model.passController,
                                              ),
                                              const SizedBox(height: 24),
                                              Text(
                                                "Confirmation :",
                                                style: blackText.szC.regfont,
                                              ),
                                              const SizedBox(height: 16),
                                              MyInput(
                                                hint:
                                                    "Confirmer votre mot de passe",
                                                isPassword: true,
                                                alternateTheme: true,
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    model.confirmPassController,
                                              ),
                                              const SizedBox(height: 24),
                                              Center(
                                                child: Column(
                                                  children: [
                                                    MyButton(
                                                      title: "Enregistrer",
                                                      onTap: () {
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        model.submitPassword();
                                                      },
                                                    ),
                                                    const SizedBox(height: 16),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
