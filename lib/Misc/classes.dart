import 'package:location/location.dart';
import 'package:flutter/material.dart';

class AnimatedRevealerController {
  Future<void> Function() toggle;
  Future<void> Function() show;
  Future<void> Function() hide;
  bool isVisible;

  void setUp({show, hide, initiallyVisible}) {
    this.show = () async {
      if (this.isVisible) return;

      await show();
      this.isVisible = true;
    };
    this.hide = () async {
      if (!this.isVisible) return;

      await hide();
      this.isVisible = false;
    };
    this.isVisible = initiallyVisible;
  }
}

class IO<T> {
  final String id;
  final String title;
  final T data;
  bool isSelected;

  IO(
    this.data, {
    @required this.id,
    this.isSelected = false,
    this.title,
  });
  void switchMe() {
    isSelected = !isSelected;
  }

  void selectMe() {
    isSelected = true;
  }

  void unselectMe() {
    isSelected = false;
  }
}

class Counter {
  int _count;

  Counter({count = 0}) : _count = count;

  increment() {
    _count++;
  }

  decrement() {
    if (_count != 0) _count--;
  }

  reset() {
    _count = 0;
  }

  get count => _count;
}

class Connect2Component {
  Map<dynamic, Function> _listOfTriggers;

  Connect2Component(Map<dynamic, Function> listOfTriggers)
      : _listOfTriggers = listOfTriggers ?? {};
  updateComponents({dynamic name}) {
    if (_listOfTriggers == null) return;

    if (name == null)
      _listOfTriggers["default"]?.call();
    else {
      _listOfTriggers[name]?.call();
    }
  }

  attachComponents(dynamic components, void Function() updater) {
    if (components is List)
      components.forEach((element) {
        _listOfTriggers.addAll({element: updater});
      });
  }

  detachAllComponents() {
    _listOfTriggers = null;
  }
}

// class InputMap {
//   final String title;
//   final Widget widget;
//   final Widget leadingWidget, trailingWidget;
//   final Widget trailingWidgetTitle;
//   final String getBuilderId;
//   final bool withGetBuilder;
//   final bool isRequired;

//   const InputMap({
//     this.title,
//     this.widget,
//     this.leadingWidget,
//     this.trailingWidget,
//     this.trailingWidgetTitle,
//     this.getBuilderId,
//     this.isRequired = false,
//   }) : withGetBuilder = getBuilderId != null;
// }

class SimplePosition {
  final double latitude;
  final double longitude;
  final double altitude;

  SimplePosition({this.latitude, this.longitude, this.altitude})
      : assert(latitude != null && longitude != null && altitude != null);

  static Future<SimplePosition> getCurrentPosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    print("good til service");

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    print("good til permission");

    _locationData = await location.getLocation().timeout(
      Duration(seconds: 5),
      onTimeout: () async {
        return await location.getLocation().timeout(
              Duration(seconds: 5),
              onTimeout: () => null,
            );
      },
    );

    print("good til location");
    if (_locationData == null) {
      print("location is null");
      return null;
    }

    return SimplePosition(
      latitude: _locationData.latitude,
      longitude: _locationData.longitude,
      altitude: _locationData.altitude,
    );
  }
}

abstract class DateUtils {
  static String toDateOnlyString(DateTime dateTime) {
    String dateOnly = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    return dateOnly;
  }

  static DateOnly stringToDateOnly(String dateOnlyString) {
    List<String> splinters = dateOnlyString.split("/");

    int year = int.parse(splinters[0]);
    int month = int.parse(splinters[1]);
    int day = int.parse(splinters[2]);
    return DateOnly(year, month, day);
  }

  static int timestampToDateOnly(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    int dateOnlyTimestamp =
        DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch;

    return dateOnlyTimestamp;
  }

  static bool sameDate(DateTime d1, DateTime d2) {
    return ((d1.year == d2.year) &&
        (d1.month == d2.month) &&
        (d1.day == d2.day));
  }
}

class DateOnly {
  final int year, month, day;

  const DateOnly(this.year, this.month, this.day);
}

class Remote<T> {
  T object;
  Remote({this.object});
}
