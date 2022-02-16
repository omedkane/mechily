import 'package:get/get.dart';
import 'package:mechily/Global/GlobalState.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Models/OneOrder.dart';
import 'package:mechily/Models/OneDish.dart';
import 'package:mechily/Models/OnePreset.dart';
import 'package:mechily/Models/OneResto.dart';
import 'package:mechily/Dialogs/Alert.dart';

class User {
  final String firstName, lastName, fullName;
  String permanentAddress;
  String image;
  String homeDescription;
  String phoneNumber;
  // SimplePosition position;
  final List<Dish> favouriteDishes;
  final List<Resto> favouriteRestos;
  final List<Preset> presets;
  final List<Order> orders;
  final Map<int, List<Order>> deliveredOrders;
  SimplePosition temporaryPosition;
  SimplePosition permanentPosition;
  String _password;
  static const _passSetterToken = "\$zcppko654zdcz3215";
  static const String orderListGetID = "orderList";
  static const String userInfoGetID = "userInfo";

  User({
    this.firstName,
    this.lastName,
    this.image,
    this.permanentAddress,
    this.phoneNumber,
    this.homeDescription,
    // this.position,
    this.temporaryPosition,
    this.permanentPosition,
    List<Dish> favouriteDishes,
    List<Resto> favouriteRestos,
    List<Preset> presets,
    List<Order> orders,
    Map<int, List<Order>> deliveredOrders,
  })  : fullName = firstName + ' ' + lastName,
        favouriteDishes = favouriteDishes ?? [],
        favouriteRestos = favouriteRestos ?? [],
        presets = presets ?? [],
        orders = orders ?? [],
        deliveredOrders = deliveredOrders ?? {};

  get address {
    return permanentAddress;
  }

  get isPositionTemporary => temporaryPosition != null;

  void setTemporaryPosition(SimplePosition position) {
    assert(position != null);

    temporaryPosition = position;

    Global.instance.update([User.userInfoGetID]);
  }

  void unsetTemporaryPosition() {
    temporaryPosition = null;
    Global.instance.update([User.userInfoGetID]);
  }

  String getPassword([token]) {
    if (token == _passSetterToken)
      return _password;
    else
      return null;
  }

  void setPassword(String value, {String token}) {
    if (token == _passSetterToken) _password = value;
  }

  static dynamic verifyPassword(String pass) {
    if (pass.length < 8) {
      return "Le mot de passe doit comprendre au moins 8 caratères !";
    }

    if (pass.removeAllWhitespace.length <= 4) {
      return "Votre mot de passe ne contient presque que des espaces !";
    }
    return true;
  }

  bool doesPasswordMatch(String pass) {
    return pass == _password;
  }

  bool get hasPassword => _password != null && _password != "";

  void updateOrderLists() {
    Global.instance.update([orderListGetID]);
  }

  void addOrder(Order order) {
    order.dateAddedToBasket = DateTime.now();
    orders.add(order);
  }

  void removeOrder(index, {shouldUpdate = false}) {
    orders.removeAt(index);
    if (shouldUpdate) updateOrderLists();
  }

  List<Order> get todayDeliveredOrders {
    int todayStamp =
        DateUtils.timestampToDateOnly(DateTime.now().millisecondsSinceEpoch);
    return deliveredOrders[todayStamp] ?? <Order>[];
  }

  void confirmAllOrders() {
    DateTime now = DateTime.now();
    int todayStamp = DateUtils.timestampToDateOnly(now.millisecondsSinceEpoch);
    bool keyExisting = deliveredOrders.containsKey(todayStamp);

    List<Order> daList = keyExisting ? deliveredOrders[todayStamp] : [];
    orders.forEach((order) {
      order.state = OrderState.delivered;
      order.deliveryDate = now;
      daList.add(order);
    });

    if (!keyExisting) deliveredOrders.addAll({todayStamp: daList});
    orders.clear();
  }

  bool isDishFavourite(Dish dish) {
    bool isFavourite = false;
    for (var favDish in favouriteDishes) {
      if (favDish.id == dish.id) {
        isFavourite = true;
        break;
      }
    }
    return isFavourite;
  }

  bool addFavouriteDish(Dish dish) {
    if (favouriteDishes.length >= 10) {
      Alert.alert("Pas plus de 10 favoris", type: AlertType.failure);
      return false;
    } else {
      favouriteDishes.add(dish);
      return true;
    }
  }

  bool removeFavouriteDish({Dish dish, int index}) {
    if (index != null) {
      favouriteDishes.removeAt(index);
      return true;
    }

    favouriteDishes.removeWhere((favDish) => favDish.id == dish.id);
    return true;
  }

  bool addPreset(String name, Order order) {
    Preset preset = Preset.fromOrder(name, order);

    presets.add(preset);
    return true;
  }

  bool removePreset(int index) {
    presets.removeAt(index);
    return true;
  }

  static dynamic fieldValidator({
    String address,
    String homeDescription,
    String phoneNumber,
  }) {
    if (address != null && address.trim().length < 3) {
      return 'Veuillez saisir une adresse correcte !';
    }
    if (homeDescription != null && homeDescription.trim().length <= 15) {
      return 'Veuillez donner une description plus précise de votre domicil ! (Au minimum 15 Caractères)';
    }
    if (phoneNumber != null &&
        (phoneNumber.trim().length != 8 ||
            !GetUtils.isNumericOnly(phoneNumber))) {
      return 'Veuillez saisir un bon numéro de téléphone Mauritanien !';
    }

    return true;
  }

  Future<void> updateUser({
    String address,
    String homeDescription,
    String phoneNumber,
    SimplePosition position,
  }) async {
    // -> Validating !

    dynamic testResults = User.fieldValidator(
      address: (position != null && address.trim() == "") ? null : address,
      homeDescription: homeDescription,
      phoneNumber: phoneNumber,
    );

    if (testResults is String) throw testResults;

    // -<

    this.permanentAddress = address;
    this.homeDescription = homeDescription;
    this.phoneNumber = phoneNumber;
    this.permanentPosition = position;

    // // ignore: unused_local_variable
    // Map<String, dynamic> updateMap = {
    //   if (address != null) ...{
    //     "address": address,
    //   },
    //   if (homeDescription != null) ...{
    //     "homeDescription": homeDescription,
    //   },
    //   if (phoneNumber != null) ...{
    //     "phoneNumber": phoneNumber,
    //   },
    //   if (position != null) ...{
    //     "position": {
    //       "latitude": position.latitude,
    //       "longitude": position.longitude,
    //       "altitude": position.altitude,
    //     }
    //   },
    // };

    // TODO update user in firebase;
  }

  Map<String, dynamic> toPersistentMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "permanentAddress": permanentAddress,
        "phoneNumber": phoneNumber,
        "favouriteDishes": favouriteDishes,
        "favouriteRestos": favouriteRestos,
        "presets": presets,
        "orders": orders,
      };
  static User persistentMapToUser(map) => User(
        firstName: map["firstName"],
        lastName: map["lastName"],
        permanentAddress: map["permanentAddress"],
        phoneNumber: map["phoneNumber"],
        favouriteDishes: map["favouriteDishes"],
        favouriteRestos: map["favouriteRestos"],
        presets: map["presets"],
        orders: map["orders"],
      );
}
