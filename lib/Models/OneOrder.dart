import 'package:mechily/Misc/classes.dart';
import 'package:mechily/Models/OneCondiment.dart';
import 'package:mechily/Models/OneResto.dart';

import './OneDish.dart';

enum OrderState { pending, inDelivery, delivered }

mixin OrderDetails {
  Dish get dish;
  List<Condiment> get dislikedCondiments;
  List<Resto> get preferedRestos;
  String get customCondimentsPreference;
  int get quantity;
  int unitPrice;

  int refreshHighestPrice() {
    int __highestPrice = 0;
    preferedRestos?.forEach((resto) {
      int restoPrice = dish.getPriceFrom(resto.id);

      if (restoPrice != null && restoPrice > __highestPrice)
        __highestPrice = restoPrice;
    });

    __highestPrice = __highestPrice > 0 ? __highestPrice : dish.price;

    unitPrice = __highestPrice;

    print("refreshed again PU: $__highestPrice");

    return __highestPrice;
  }
}

enum OrderGetIDs {
  quantity,
  unitPrice,
  totalPrice,
  restos,
  condiments,
  customPreference
}

class Order extends Connect2Component
    with OrderDetails
    implements OrderDetails {
  // ignore: unused_field
  final String _id;
  final Dish dish;
  List<Condiment> dislikedCondiments;
  List<Resto> _preferedRestos;
  String customCondimentsPreference;
  int _quantity;
  DateTime dateAddedToBasket;
  DateTime deliveryDate;
  OrderState state = OrderState.pending;
  bool fastDelivery = true;
  int unitPrice;

  Order({
    id,
    this.dish,
    this.customCondimentsPreference,
    Map<dynamic, Function> listOfTriggers,
    List<Condiment> dislikes,
    List<Resto> preferedRestos,
    int quantity,
  })  : assert(dish != null),
        _id = id ?? "order" + DateTime.now().millisecondsSinceEpoch.toString(),
        dislikedCondiments = dislikes ?? [],
        _preferedRestos = preferedRestos ?? [],
        assert((quantity == null) || (quantity >= 1)),
        _quantity = quantity ?? 1,
        super(listOfTriggers) {
    if (_preferedRestos.isNotEmpty)
      refreshHighestPrice();
    else
      unitPrice = dish.price;
  }

  int get quantity {
    return _quantity;
  }

  int get totalPrice {
    return unitPrice * _quantity;
  }

  bool get isQuickOrder {
    bool noDislikes = this.dislikedCondiments.length == 0;
    bool noPreferedRestos = this.preferedRestos.length == 0;
    bool noCustomPreference = (customCondimentsPreference?.length ?? 0) == 0;
    return noDislikes && noPreferedRestos && noCustomPreference;
  }

  void increaseQty() {
    quantity++;
    updateComponents(name: OrderGetIDs.quantity);
  }

  void decreaseQty() {
    quantity--;
    updateComponents(name: OrderGetIDs.quantity);
  }

  set quantity(value) {
    if (state == OrderState.delivered) return;

    if (value > 0) _quantity = value;
  }

  get preferedRestos => _preferedRestos;

  void _restoChangeRoutine() {
    refreshHighestPrice();
    updateComponents(name: OrderGetIDs.restos);
  }

  set preferedRestos(val) {
    _preferedRestos = val;
    _restoChangeRoutine();
  }

  void removeRestaurant(int index) {
    _preferedRestos.removeAt(index);

    _restoChangeRoutine();
  }

  void addRestaurant(Resto resto) {
    _preferedRestos.add(resto);

    _restoChangeRoutine();
  }

  void addToDislikes(Condiment dislikedCondiment) {
    dislikedCondiments.add(dislikedCondiment);
    updateComponents(name: OrderGetIDs.condiments);
  }

  void removeFromDislikes(int index) {
    dislikedCondiments.removeAt(index);
    updateComponents(name: OrderGetIDs.condiments);
  }
}
