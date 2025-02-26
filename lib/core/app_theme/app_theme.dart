// // import 'package:flutter/material.dart';

// // ThemeData getApplicationTheme() {
// //   return ThemeData(
// //     brightness: Brightness.light,
// //     primarySwatch: Colors.blue,
// //     scaffoldBackgroundColor: const Color(0xfff2fafa),
// //     fontFamily: 'Montserrat Regular',
// //     elevatedButtonTheme: ElevatedButtonThemeData(
// //       style: ElevatedButton.styleFrom(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(40),
// //         ),
// //         padding: const EdgeInsets.symmetric(vertical: 16.0),
// //         minimumSize: const Size(double.infinity, 50),
// //         backgroundColor: const Color.fromARGB(255, 0, 94, 255),
// //         textStyle: const TextStyle(
// //           fontSize: 25.0,
// //           fontFamily: 'Montserrat Bold',
// //           color: Colors.white,
// //         ),
// //       ),
// //     ),
// //   );
// // }

// // // Define a dark theme that complements the existing color scheme
// // ThemeData getDarkTheme() {
// //   final base = ThemeData.dark();
// //   return base.copyWith(
// //     primaryColor: const Color.fromARGB(255, 0, 94, 255),
// //     scaffoldBackgroundColor: Colors.black,
// //     cardColor: const Color(0xFF121212), // Dark card color
// //     textTheme: base.textTheme.apply(
// //       fontFamily: 'Montserrat Regular',
// //       bodyColor: Colors.white,
// //       displayColor: Colors.white,
// //     ),
// //     elevatedButtonTheme: ElevatedButtonThemeData(
// //       style: ElevatedButton.styleFrom(
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(40),
// //         ),
// //         backgroundColor: const Color.fromARGB(255, 0, 94, 255),
// //       ),
// //     ),
// //   );
// // }

// import 'package:flutter/material.dart';

// ThemeData getApplicationTheme() {
//   // Start with a base light theme
//   final base = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: const Color(0xfff2fafa),
//     fontFamily: 'Montserrat Regular',
//   );

//   return base.copyWith(
//     // Primary color used for accents, app bars, buttons, etc.
//     primaryColor: const Color.fromARGB(255, 0, 94, 255),

//     // Card color for containers, cards, etc.
//     cardColor: Colors.white,

//     // Divider color for subtle separations
//     dividerColor: Colors.grey.shade300,

//     // AppBar styling
//     appBarTheme: base.appBarTheme.copyWith(
//       backgroundColor: const Color.fromARGB(255, 0, 94, 255),
//       elevation: 4,
//       iconTheme: const IconThemeData(color: Colors.white),
//       titleTextStyle: const TextStyle(
//         fontFamily: 'Montserrat Bold',
//         fontSize: 20,
//         color: Colors.white,
//       ),
//       centerTitle: true,
//     ),

//     // Text styling
//     textTheme: base.textTheme.copyWith(
//       // Example: bodyMedium for your main content text color
//       bodyMedium: base.textTheme.bodyMedium?.copyWith(
//         color: Colors.black87,
//       ),
//       // You can override more text styles as needed
//     ),

//     // Elevated buttons (like Book Session)
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         minimumSize: const Size(double.infinity, 50),
//         backgroundColor: const Color.fromARGB(255, 0, 94, 255),
//         textStyle: const TextStyle(
//           fontSize: 25.0,
//           fontFamily: 'Montserrat Bold',
//           color: Colors.white,
//         ),
//       ),
//     ),
//   );
// }

// // Define a dark theme that complements the existing color scheme
// ThemeData getDarkTheme() {
//   // Start with a base dark theme
//   final base = ThemeData.dark();

//   return base.copyWith(
//     brightness: Brightness.dark,
//     // Primary accent color remains the same
//     primaryColor: const Color.fromARGB(255, 0, 94, 255),

//     // Dark scaffold background
//     scaffoldBackgroundColor: Colors.black,

//     // Dark card color for containers, cards, etc.
//     cardColor: const Color(0xFF121212),

//     // Example divider color in dark mode
//     dividerColor: Colors.grey.shade700,

//     // AppBar styling in dark mode
//     appBarTheme: base.appBarTheme.copyWith(
//       backgroundColor: const Color.fromARGB(255, 0, 94, 255),
//       elevation: 4,
//       iconTheme: const IconThemeData(color: Colors.white),
//       titleTextStyle: const TextStyle(
//         fontFamily: 'Montserrat Bold',
//         fontSize: 20,
//         color: Colors.white,
//       ),
//       centerTitle: true,
//     ),

//     // Text styling in dark mode
//     textTheme: base.textTheme.apply(
//       fontFamily: 'Montserrat Regular',
//       bodyColor: Colors.white,
//       displayColor: Colors.white,
//     ),

//     // Elevated buttons in dark mode
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(40),
//         ),
//         backgroundColor: const Color.fromARGB(255, 0, 94, 255),
//         foregroundColor: Colors.white,
//       ),
//     ),
//   );
// }

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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: const Size(0, 50),
        backgroundColor: const Color.fromARGB(255, 0, 94, 255),
        textStyle: const TextStyle(
          fontSize: 25.0,
          fontFamily: 'Montserrat Bold',
          color: Colors.white,
        ),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 0, 29, 56),
      selectedItemColor: Color.fromARGB(255, 0, 94, 255),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      elevation: 8,
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
    primaryColor: const Color.fromARGB(255, 0, 94, 255),

    // Dark scaffold background
    scaffoldBackgroundColor: Colors.black87,

    // Dark card color for containers, cards, etc.
    cardColor: Colors.black26,

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

    // Elevated buttons in dark mode
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 94, 255),
        foregroundColor: Colors.white,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black87,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey.shade500,
      selectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      elevation: 8,
    ),
  );
}
