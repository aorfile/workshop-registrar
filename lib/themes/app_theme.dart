import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Custom color palette
  static const Color primaryGreen = Color(0xFF10B981);    // Emerald 500
  static const Color lightGreen = Color(0xFF34D399);      // Emerald 400
  static const Color darkGreen = Color(0xFF059669);       // Emerald 600
  static const Color successGreen = Color(0xFF00A36C);    // Custom success color
  static const Color surfaceLight = Color(0xFFF9FAFB);    // Gray 50
  static const Color errorRed = Color(0xFFDC2626);        // Red 600
  static const Color warningAmber = Color(0xFFFBBF24);    // Amber 400
  static const Color infoBlue = Color(0xFF3B82F6);        // Blue 500

  // Neutral colors
  static const Color neutral900 = Color(0xFF111827);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral50 = Color(0xFFF9FAFB);

  // Shadow colors
  static final Color shadowLight = Colors.black.withOpacity(0.05);
  static final Color shadowDark = Colors.black.withOpacity(0.1);

  // Current user info
  static const String currentDateTime = '2025-03-12 21:13:42';
  static const String currentUser = 'aorfile';

  // Elevation values
  static const double elevationNone = 0;
  static const double elevationXs = 1;
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevationLg = 8;

  // Border radius values
  static final double radiusSm = 8;
  static final double radiusMd = 12;
  static final double radiusLg = 16;
  static final double radiusXl = 24;
  static final double radiusFull = 9999;

  // Spacing values
  static const double spaceXxs = 4;
  static const double spaceXs = 8;
  static const double spaceSm = 12;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;

  // Button sizes
  static const double buttonHeight = 48;
  static const double iconButtonSize = 40;

  // Animation durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
      primary: primaryGreen,
      secondary: lightGreen,
      tertiary: darkGreen,
      error: errorRed,
      surface: surfaceLight,
      background: neutral50,
      onBackground: neutral900,
      onSurface: neutral800,
      surfaceTint: primaryGreen,
    ),
    
    scaffoldBackgroundColor: neutral50,

    // Text Theme using Google Fonts
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 48,
        height: 1.2,
        fontWeight: FontWeight.bold,
        color: neutral900,
        letterSpacing: -1,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 36,
        height: 1.2,
        fontWeight: FontWeight.bold,
        color: neutral900,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 28,
        height: 1.3,
        fontWeight: FontWeight.bold,
        color: neutral900,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 24,
        height: 1.3,
        fontWeight: FontWeight.w600,
        color: neutral900,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        height: 1.4,
        fontWeight: FontWeight.w600,
        color: neutral900,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        height: 1.4,
        fontWeight: FontWeight.w600,
        color: primaryGreen,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w600,
        color: neutral800,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        color: neutral700,
        letterSpacing: 0.1,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: neutral600,
        letterSpacing: 0.1,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 0.1,
      ),
    ),

    // Card Theme
    cardTheme: CardTheme(
      elevation: elevationXs,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        side: BorderSide(
          color: neutral200,
          width: 1,
        ),
      ),
      color: Colors.white,
      margin: EdgeInsets.zero,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      selectedTileColor: primaryGreen.withOpacity(0.1),
      selectedColor: primaryGreen,
      tileColor: Colors.white,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: neutral300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: neutral300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: primaryGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: errorRed),
      ),
      contentPadding: EdgeInsets.all(spaceMd),
      hintStyle: GoogleFonts.inter(
        color: neutral500,
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.inter(
        color: neutral600,
        fontSize: 14,
      ),
      floatingLabelStyle: const TextStyle(color: primaryGreen),
      prefixIconColor: neutral500,
      suffixIconColor: neutral500,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusFull),
      ),
      side: BorderSide(color: neutral300),
      backgroundColor: Colors.white,
      selectedColor: primaryGreen.withOpacity(0.1),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        color: neutral700,
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceXs,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(elevationNone),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return darkGreen;
            if (states.contains(WidgetState.hovered)) return darkGreen;
            if (states.contains(WidgetState.disabled)) return neutral300;
            return primaryGreen;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) return neutral500;
            return Colors.white;
          },
        ),
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, buttonHeight)),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return darkGreen;
            if (states.contains(WidgetState.hovered)) return darkGreen;
            if (states.contains(WidgetState.disabled)) return neutral400;
            return primaryGreen;
          },
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
        ),
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return darkGreen;
            if (states.contains(WidgetState.hovered)) return darkGreen;
            if (states.contains(WidgetState.disabled)) return neutral400;
            return primaryGreen;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return primaryGreen.withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return primaryGreen.withOpacity(0.05);
            }
            return Colors.transparent;
          },
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(spaceSm)),
        minimumSize: const WidgetStatePropertyAll(Size(iconButtonSize, iconButtonSize)),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: primaryGreen,
      size: 24,
    ),

    // FAB Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: elevationMd,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: elevationNone,
      backgroundColor: Colors.white,
      foregroundColor: neutral900,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: neutral900,
      ),
      iconTheme: const IconThemeData(
        color: neutral700,
        size: 24,
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: neutral200,
      thickness: 1,
      space: spaceMd,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: neutral800,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );

  // ... (previous code remains the same until darkTheme)

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
      primary: lightGreen,
      secondary: primaryGreen,
      tertiary: darkGreen,
      error: const Color(0xFFFCA5A5),
      surface: neutral800,
      background: neutral900,
      onBackground: Colors.white,
      onSurface: Colors.white,
      surfaceTint: lightGreen,
    ),

    scaffoldBackgroundColor: neutral900,

    // Card Theme
    cardTheme: CardTheme(
      elevation: elevationXs,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLg),
        side: BorderSide(
          color: neutral700,
          width: 1,
        ),
      ),
      color: neutral800,
      margin: EdgeInsets.zero,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceSm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      selectedTileColor: lightGreen.withOpacity(0.1),
      selectedColor: lightGreen,
      tileColor: neutral800,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: neutral800,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: neutral600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: BorderSide(color: neutral600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: lightGreen, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMd),
        borderSide: const BorderSide(color: Color(0xFFFCA5A5)),
      ),
      contentPadding: EdgeInsets.all(spaceMd),
      hintStyle: GoogleFonts.inter(
        color: neutral500,
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.inter(
        color: neutral400,
        fontSize: 14,
      ),
      floatingLabelStyle: const TextStyle(color: lightGreen),
      prefixIconColor: neutral400,
      suffixIconColor: neutral400,
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusFull),
      ),
      side: BorderSide(color: neutral600),
      backgroundColor: neutral800,
      selectedColor: lightGreen.withOpacity(0.2),
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        color: neutral300,
        fontWeight: FontWeight.w500,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: spaceMd,
        vertical: spaceXs,
      ),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll(elevationNone),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: spaceLg,
            vertical: spaceMd,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return darkGreen;
            if (states.contains(WidgetState.hovered)) return darkGreen;
            if (states.contains(WidgetState.disabled)) return neutral700;
            return lightGreen;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) return neutral500;
            return Colors.white;
          },
        ),
        minimumSize: const WidgetStatePropertyAll(Size(double.infinity, buttonHeight)),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return primaryGreen;
            if (states.contains(WidgetState.hovered)) return primaryGreen;
            if (states.contains(WidgetState.disabled)) return neutral600;
            return lightGreen;
          },
        ),
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: spaceMd,
            vertical: spaceSm,
          ),
        ),
      ),
    ),

    // Icon Button Theme
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return primaryGreen;
            if (states.contains(WidgetState.hovered)) return primaryGreen;
            if (states.contains(WidgetState.disabled)) return neutral600;
            return lightGreen;
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return lightGreen.withOpacity(0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return lightGreen.withOpacity(0.1);
            }
            return Colors.transparent;
          },
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(spaceSm)),
        minimumSize: const WidgetStatePropertyAll(Size(iconButtonSize, iconButtonSize)),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: lightGreen,
      size: 24,
    ),

    // FAB Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightGreen,
      foregroundColor: Colors.white,
      elevation: elevationMd,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      elevation: elevationNone,
      backgroundColor: neutral800,
      foregroundColor: Colors.white,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: neutral300,
        size: 24,
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: neutral700,
      thickness: 1,
      space: spaceMd,
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: neutral800,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      contentTextStyle: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}