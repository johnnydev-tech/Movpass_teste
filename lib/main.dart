import 'package:flutter/material.dart';
import 'package:movpass_test/views/splash.dart';

void main() {
  runApp(MaterialApp(
    theme: new ThemeData(
        primaryColor: Color(0xffE9A945), accentColor: Color(0xff242A2C)),
    title: 'Movpass',
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
