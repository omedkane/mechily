import 'package:mechily/AppStyle.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Navigation/FrontPage.dart';
import 'package:mechily/Pages/SettingsScreen/SettingTile.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/history_view.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mechily/Pages/SettingsScreen/Subscreens/security_view.dart';

class SettingsScreen extends StatelessWidget with FrontPage {
  final user = Global.store.currentUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPaddings.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mon", style: blackText.szC.medfont),
                  Text(
                    "Profil",
                    style: shiroText.extSzD.boldfont,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(bottom: 16, top: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 180,
                          width: 180,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            boxShadow: matShade,
                            borderRadius: BorderRadius.circular(32),
                            image: DecorationImage(
                              image: AssetImage(user.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Nom:", style: shiroText.extSzC.semfont),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(user.fullName,
                                style: blackText.szC.medfont),
                          ),
                          const SizedBox(height: 16),
                          Text("Adresse:", style: shiroText.extSzC.semfont),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(user.address,
                                style: blackText.szC.medfont),
                          ),
                          const SizedBox(height: 16),
                          Text("Téléphone:", style: shiroText.extSzC.semfont),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text("+222 ${user.phoneNumber}",
                                style: blackText.szC.medfont),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
        SettingTile(
          icon: MaterialCommunityIcons.account_edit,
          title: "Renseignements",
          subtitle: "Veuillez nous aider à vous localiser plus facilement",
          onTap: () {
            Get.to(InformationSettings());
          },
        ),
        ...[
          SettingTile(
            icon: MaterialCommunityIcons.fingerprint,
            title: "Sécurité",
            subtitle:
                "Changer votre mot de passe ou éxiger authentification avant chaque commande",
            onTap: () {
              Get.to(SecurityScreen());
            },
          ),
          SettingTile(
            icon: MaterialCommunityIcons.history,
            title: "Historique",
            subtitle: "Ici vous pourrez consulter vos anciennes commandes",
            isDisabled: Global.store.currentUser.deliveredOrders.length == 0,
            onTap: () {
              Get.to(HistoryScreen());
            },
            onDisabledTap: () {
              Alert.alert("Aucune de vos commandes n'a encore été livrée !",
                  type: AlertType.info);
            },
          ),
          SettingTile(
            icon: MaterialCommunityIcons.exclamation,
            title: "À propos de nous",
            subtitle:
                "Faisons connaissances à travers différents résaux sociaux !",
          ),
        ]
            .map(
              (elem) => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: elem,
              ),
            )
            .toList(),
      ],
    );
  }
}
