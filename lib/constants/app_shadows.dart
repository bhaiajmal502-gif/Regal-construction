import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow elevationSmall = BoxShadow(
    color: Color.fromARGB(12, 0, 0, 0),
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const BoxShadow elevationMedium = BoxShadow(
    color: Color.fromARGB(18, 0, 0, 0),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow elevationLarge = BoxShadow(
    color: Color.fromARGB(25, 0, 0, 0),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const BoxShadow elevationXLarge = BoxShadow(
    color: Color.fromARGB(32, 0, 0, 0),
    blurRadius: 24,
    offset: Offset(0, 12),
  );

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color.fromARGB(14, 0, 0, 0),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color.fromARGB(20, 0, 0, 0),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> floatingActionButtonShadow = [
    BoxShadow(
      color: Color.fromARGB(30, 0, 0, 0),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ];
}
