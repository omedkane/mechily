import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Models/OneUser.dart';

class SecurityScreenModel extends GetxController with NoticeMixin {
  static const _passSetterToken = "\$zcppko654zdcz3215";
  final RxString notice =
      "Veuillez vous assurer de la sûreté de votre mot de passe, il doît comprendre au moins 8 caractères"
          .obs;

  TextEditingController passController;
  TextEditingController confirmPassController;

  SecurityScreenModel() {
    String currentPass = Global.store.currentUser.getPassword(_passSetterToken);
    passController = TextEditingController(text: currentPass);
    confirmPassController = TextEditingController(text: currentPass);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    if (Global.params.passwordPrefered == true &&
        !Global.store.currentUser.hasPassword) {
      Global.params.passwordPrefered = false;
    }
    super.onClose();
  }

  void setErrorMessage(String message) {
    AlertType type = AlertType.failure;
    Alert.alert(
      message,
      type: type,
      onExit: () {
        setNotice(message, type);
      },
    );
  }

  void submitPassword() {
    User user = Global.store.currentUser;
    String pass = passController.text;
    String confirmPass = confirmPassController.text;

    // print("pass: $pass");
    // print("confirmPass: $confirmPass");

    dynamic testResults = User.verifyPassword(pass);

    if (testResults is String) {
      setErrorMessage(testResults);
      return;
    }

    if (pass != confirmPass) {
      setErrorMessage("Les mots de passe ne correspondent pas !");
      return;
    }
    user.setPassword(pass, token: _passSetterToken);

    Alert.alert(
      "Enregistré avec succés !",
      onExit: () {
        setNotice("Enregistré avec succés !", AlertType.success);
      },
    );
  }
}
