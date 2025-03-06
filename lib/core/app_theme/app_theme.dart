import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  // Start with a base light theme
  final base = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xfff2fafa),
    fontFamily: 'Montserrat Regular',
  );

  return base.copyWith(
    // Primary color used for accents, app bars, buttons, etc.
    primaryColor: const Color.fromARGB(255, 0, 94, 255),

    // Card color for containers, cards, etc.
    cardColor: Colors.white,

    // Divider color for subtle separations
    dividerColor: Colors.grey.shade300,

    // AppBar styling
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

    // Text styling
    textTheme: base.textTheme.copyWith(
      // Example: bodyMedium for your main content text color
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        color: Colors.black87,
      ),
      // You can override more text styles as needed
    ),

    // Elevated buttons (like Book Session)
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(40),
    //     ),
    //     padding: const EdgeInsets.symmetric(vertical: 16.0),
    //     minimumSize: const Size(0, 50),
    //     backgroundColor: const Color.fromARGB(255, 0, 94, 255),
    //     textStyle: const TextStyle(
    //       fontSize: 25.0,
    //       fontFamily: 'Montserrat Bold',
    //       color: Colors.white,
    //     ),
    //   ),
    // ),

    // Updated bottom navigation bar theme
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
          0, // No elevation as we're using a custom container with shadow
    ),
  );
}

// Define a dark theme that complements the existing color scheme
ThemeData getDarkTheme() {
  // Start with a base dark theme
  final base = ThemeData.dark();
  return base.copyWith(
    brightness: Brightness.dark,
    // Primary accent color remains the same
    primaryColor: const Color.fromARGB(255, 8, 70, 179),

    // Dark scaffold background
    scaffoldBackgroundColor: Colors.black87,

    // Dark card color for containers, cards, etc.
    cardColor: const Color(0xFF1E1E1E),
    // color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,

    // Example divider color in dark mode
    dividerColor: Colors.grey.shade700,

    // AppBar styling in dark mode
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

    // Text styling in dark mode
    textTheme: base.textTheme.apply(
      fontFamily: 'Montserrat Regular',
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(40),
    //     ),
    //     padding: const EdgeInsets.symmetric(vertical: 16.0),
    //     minimumSize: const Size(0, 50),
    //     backgroundColor: const Color.fromARGB(255, 0, 94, 255),
    //     textStyle: const TextStyle(
    //       fontSize: 25.0,
    //       fontFamily: 'Montserrat Bold',
    //       color: Colors.white,
    //     ),
    //   ),
    // ),

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
