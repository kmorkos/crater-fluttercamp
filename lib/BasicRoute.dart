import 'package:flutter/material.dart';

class BasicRoute<T> extends PageRouteBuilder<T> {
  BasicRoute(Widget nextScreen, {Duration transitionDuration: const Duration(microseconds: 1)}) : super(
    pageBuilder: (_, __, ___) => nextScreen,
    transitionDuration: transitionDuration, // Gives an error if the transition happens instantaneously
  );
}