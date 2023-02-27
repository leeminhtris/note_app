import 'package:flutter/material.dart';

ScaffoldMessengerState messageSackBar(context, String text) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
        content: Text(text), backgroundColor: Colors.deepOrange),
    );
}