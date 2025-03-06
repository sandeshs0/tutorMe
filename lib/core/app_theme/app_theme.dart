import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  final base = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xfff2fafa),
    fontFamily: 'Montserrat Regular',
  );

  return base.copyWith(
    primaryColor: const Color.fromARGB(255, 0, 94, 255),

    cardColor: Colors.white,

    dividerColor: Colors.grey.shade300,

    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: const Color.fromARGB(255, 0, 94, 255),
      elevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontFamily: 'Montserrat Bold',
        fontSize: 20,
        color: Colors.white,
      ),
      centerTitle: true,
    ),

    textTheme: base.textTheme.copyWith(
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        color: Colors.black87,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 0, 94, 255),
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat Bold',
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontFamily: 'Montserrat Regular',
      ),
      elevation:
          0,
    ),
  );
}

ThemeData getDarkTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 8, 70, 179),

    scaffoldBackgroundColor: Colors.black87,

    cardColor: const Color(0xFF1E1E1E),

    dividerColor: Colors.grey.shade700,

    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: const Color.fromARGB(255, 0, 94, 255),
      elevation: 4,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontFamily: 'Montserrat Bold',
        fontSize: 20,
        color: Colors.white,
      ),
      centerTitle: true,
    ),

    textTheme: base.textTheme.apply(
      fontFamily: 'Montserrat Regular',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF202020),
      selectedItemColor: const Color.fromARGB(255, 0, 94, 255),
      unselectedItemColor: Colors.grey.shade400,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat Bold',
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontFamily: 'Montserrat Regular',
      ),
      elevation: 0,
    ),
  );
}
