import 'package:flutter/material.dart';
import 'package:main/homepage.dart';
import 'package:main/datasource.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
fontFamily: 'Circular',
      primaryColor: primaryBlack
    ),
    home: const HomePage(),
  ));
}