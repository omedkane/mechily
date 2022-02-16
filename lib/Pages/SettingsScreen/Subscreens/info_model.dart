import 'package:get/get.dart';
import 'package:mechily/Components/InputGroupController.dart';
import 'package:mechily/Dialogs/Alert.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';

enum InfoForm { address, phone, homeDescription }

class InformationSettingsModel extends GetxController with NoticeMixin {
  final InputGroupController groupController = InputGroupController<InfoForm>(
    3,
    lastInputRef: InfoForm.homeDescription,
    initialValues: {
      InfoForm.address: Global.store.currentUser.address,
      InfoForm.homeDescription: Global.store.currentUser.homeDescription,
      InfoForm.phone: Global.store.currentUser.phoneNumber
    },
  );
  final user = Global.store.currentUser;

  final RxString notice =
      "Nous utiliserons ces informations pour vous livrer vos commandes, veuillez vous assurer de leur véracité"
          .obs;

  String addressGetID = "location";

  SimplePosition position;

  bool get locationAvailable {
    return position != null;
  }

  void submit() {
    // TODO: Get Address
    // TODO: Get Phone Number
    // TODO: Get Description Of Home
    String address = groupController.getInputText(InfoForm.address);
    String phone = groupController.getInputText(InfoForm.phone);
    String homeDescription =
        groupController.getInputText(InfoForm.homeDescription);

    user
        .updateUser(
      address: address,
      homeDescription: homeDescription,
      phoneNumber: phone,
      position: position,
    )
        .then((_) {
      Alert.alert(
        "Modifications Enregistrées !",
        type: AlertType.success,
        onExit: () {
          setNotice("Modifications Enregistrées !", AlertType.success);
        },
      );
    }).catchError((error) {
      Alert.alert(
        error,
        type: AlertType.failure,
        onExit: () {
          setNotice(error, AlertType.failure);
        },
      );
    });

    // print(homeDescription);
  }
}
