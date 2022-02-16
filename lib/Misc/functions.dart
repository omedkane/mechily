import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

bool isFunction<T>(object) => object is T Function();
bool isFuture<T>(object) => object is Future<T> Function();

bool isFunctionOrFuture<T>(object) =>
    object is T Function() || object is Future<T> Function();

padZero(num number) => number?.toString()?.padLeft(2, '0');

String cutText([String text, int limit]) {
  if (text.length <= limit) return text;

  return text.replaceRange(limit, text.length, "..");
}

bool isMauritanianNumber(String phoneNumber) {
  return phoneNumber.length == 8 && !phoneNumber.startsWith('0');
}

int reverseIndex(dynamic array, index) {
  assert(array is List || array is Map);
  return (array.length - 1) - index;
}

Color solidify(Color source) {
  double opacityDifference = ((1 - source.opacity) * 255);
  double r = (opacityDifference + (source.opacity * source.red)),
      g = (opacityDifference + (source.opacity * source.green)),
      b = (opacityDifference + (source.opacity * source.blue));
  return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
}

Animation<T> getAnimation<T>(T begin, T end, CurvedAnimation curvedAnimation,
    {bool reverse = false}) {
  // -> Variables !
  T realBegin = reverse ? end : begin;
  T realEnd = reverse ? begin : end;

  CurvedAnimation realCurve = reverse
      ? CurvedAnimation(
          parent: curvedAnimation.parent,
          curve: curvedAnimation.curve.flipped,
        )
      : curvedAnimation;

  return Tween<T>(begin: realBegin, end: realEnd).animate(realCurve);
}
