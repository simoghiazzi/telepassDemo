import 'package:flutter/material.dart';

/// Based on the colors shown in the Figma mockup, I have defined a complete palette structure.
/// For the sake of simplicity, I have defined all the colors in a single class and just the lightTheme is used as for this demo.
class AppColors {
  // Light mode colors
  static const Color primaryLight50 = Color(0xFFE3F2FD);
  static const Color primaryLight100 = Color(0xFFBBDEFB);
  static const Color primaryLight200 = Color(0xFF90CAF9);
  static const Color primaryLight300 = Color(0xFF64B5F6);
  static const Color primaryLight400 = Color(0xFF42A5F5);
  static const Color primaryLight500 = Color(0xFF2196F3);
  static const Color primaryLight600 = Color(0xFF1E88E5);
  static const Color primaryLight700 = Color(0xFF1976D2);
  static const Color primaryLight800 = Color(0xFF1565C0);
  static const Color primaryLight900 = Color(0xFF0D47A1);
  static const Color primaryLight950 = Color(0xFF082D7A);
  static const Color primaryLight1000 = Color(0xFF061A40);

  static const Color errorLight0 = Color(0xFFFFEBEE);
  static const Color errorLight25 = Color(0xFFFFCDD2);
  static const Color errorLight50 = Color(0xFFEF9A9A);
  static const Color errorLight75 = Color(0xFFE57373);
  static const Color errorLight100 = Color(0xFFEF5350);

  static const Color warningLight0 = Color(0xFFFFF8E1);
  static const Color warningLight25 = Color(0xFFFFECB3);
  static const Color warningLight50 = Color(0xFFFFE082);
  static const Color warningLight75 = Color(0xFFFFD54F);
  static const Color warningLight100 = Color(0xFFFFCA28);

  static const Color successLight0 = Color(0xFFE8F5E9);
  static const Color successLight25 = Color(0xFFC8E6C9);
  static const Color successLight50 = Color(0xFFA5D6A7);
  static const Color successLight75 = Color(0xFF81C784);
  static const Color successLight100 = Color(0xFF66BB6A);

  static const Color greyLight0 = Color(0xFFFFFFFF);
  static const Color greyLight50 = Color(0xFFF5F5F5);
  static const Color greyLight100 = Color(0xFFEEEEEE);
  static const Color greyLight200 = Color(0xFFE0E0E0);
  static const Color greyLight300 = Color(0xFFBDBDBD);
  static const Color greyLight400 = Color(0xFF9E9E9E);
  static const Color greyLight500 = Color(0xFF757575);
  static const Color greyLight600 = Color(0xFF616161);
  static const Color greyLight700 = Color(0xFF424242);
  static const Color greyLight800 = Color(0xFF303030);
  static const Color greyLight900 = Color(0xFF212121);
  static const Color greyLight950 = Color(0xFF121212);
  static const Color greyLight1000 = Color(0xFF000000);

  // Linear gradient
  static const Color linearTop = Color(0xFF64B5F6);
  static const Color linearBottom = Color(0xFF1976D2);
}

@immutable
class CustomPalette extends ThemeExtension<CustomPalette> {
  // Primary Colors
  final Color primary50;
  final Color primary100;
  final Color primary200;
  final Color primary300;
  final Color primary400;
  final Color primary500;
  final Color primary600;
  final Color primary700;
  final Color primary800;
  final Color primary900;
  final Color primary950;
  final Color primary1000;

  // Error Colors
  final Color error0;
  final Color error25;
  final Color error50;
  final Color error75;
  final Color error100;

  // Warning Colors
  final Color warning0;
  final Color warning25;
  final Color warning50;
  final Color warning75;
  final Color warning100;

  // Success Colors
  final Color success0;
  final Color success25;
  final Color success50;
  final Color success75;
  final Color success100;

  // Grey Colors
  final Color grey0;
  final Color grey50;
  final Color grey100;
  final Color grey200;
  final Color grey300;
  final Color grey400;
  final Color grey500;
  final Color grey600;
  final Color grey700;
  final Color grey800;
  final Color grey900;
  final Color grey950;
  final Color grey1000;

  final Color linearTop;
  final Color linearBottom;

  const CustomPalette({
    // Primary
    required this.primary50,
    required this.primary100,
    required this.primary200,
    required this.primary300,
    required this.primary400,
    required this.primary500,
    required this.primary600,
    required this.primary700,
    required this.primary800,
    required this.primary900,
    required this.primary950,
    required this.primary1000,
    // Error
    required this.error0,
    required this.error25,
    required this.error50,
    required this.error75,
    required this.error100,
    // Warning
    required this.warning0,
    required this.warning25,
    required this.warning50,
    required this.warning75,
    required this.warning100,
    // Success
    required this.success0,
    required this.success25,
    required this.success50,
    required this.success75,
    required this.success100,
    // Grey
    required this.grey0,
    required this.grey50,
    required this.grey100,
    required this.grey200,
    required this.grey300,
    required this.grey400,
    required this.grey500,
    required this.grey600,
    required this.grey700,
    required this.grey800,
    required this.grey900,
    required this.grey950,
    required this.grey1000,
    // Gradient
    required this.linearTop,
    required this.linearBottom,
  });

  @override
  CustomPalette copyWith({
    Color? primary50,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primary500,
    Color? primary600,
    Color? primary700,
    Color? primary800,
    Color? primary900,
    Color? primary950,
    Color? primary1000,
    Color? error0,
    Color? error25,
    Color? error50,
    Color? error75,
    Color? error100,
    Color? warning0,
    Color? warning25,
    Color? warning50,
    Color? warning75,
    Color? warning100,
    Color? success0,
    Color? success25,
    Color? success50,
    Color? success75,
    Color? success100,
    Color? grey0,
    Color? grey50,
    Color? grey100,
    Color? grey200,
    Color? grey300,
    Color? grey400,
    Color? grey500,
    Color? grey600,
    Color? grey700,
    Color? grey800,
    Color? grey900,
    Color? grey950,
    Color? grey1000,
    Color? linearTop,
    Color? linearBottom,
  }) {
    return CustomPalette(
      primary50: primary50 ?? this.primary50,
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      primary400: primary400 ?? this.primary400,
      primary500: primary500 ?? this.primary500,
      primary600: primary600 ?? this.primary600,
      primary700: primary700 ?? this.primary700,
      primary800: primary800 ?? this.primary800,
      primary900: primary900 ?? this.primary900,
      primary950: primary950 ?? this.primary950,
      primary1000: primary1000 ?? this.primary1000,
      error0: error0 ?? this.error0,
      error25: error25 ?? this.error25,
      error50: error50 ?? this.error50,
      error75: error75 ?? this.error75,
      error100: error100 ?? this.error100,
      warning0: warning0 ?? this.warning0,
      warning25: warning25 ?? this.warning25,
      warning50: warning50 ?? this.warning50,
      warning75: warning75 ?? this.warning75,
      warning100: warning100 ?? this.warning100,
      success0: success0 ?? this.success0,
      success25: success25 ?? this.success25,
      success50: success50 ?? this.success50,
      success75: success75 ?? this.success75,
      success100: success100 ?? this.success100,
      grey0: grey0 ?? this.grey0,
      grey50: grey50 ?? this.grey50,
      grey100: grey100 ?? this.grey100,
      grey200: grey200 ?? this.grey200,
      grey300: grey300 ?? this.grey300,
      grey400: grey400 ?? this.grey400,
      grey500: grey500 ?? this.grey500,
      grey600: grey600 ?? this.grey600,
      grey700: grey700 ?? this.grey700,
      grey800: grey800 ?? this.grey800,
      grey900: grey900 ?? this.grey900,
      grey950: grey950 ?? this.grey950,
      grey1000: grey1000 ?? this.grey1000,
      linearTop: linearTop ?? this.linearTop,
      linearBottom: linearBottom ?? this.linearBottom,
    );
  }

  @override
  CustomPalette lerp(ThemeExtension<CustomPalette>? other, double t) {
    if (other is! CustomPalette) return this;
    return CustomPalette(
      primary50: Color.lerp(primary50, other.primary50, t)!,
      primary100: Color.lerp(primary100, other.primary100, t)!,
      primary200: Color.lerp(primary200, other.primary200, t)!,
      primary300: Color.lerp(primary300, other.primary300, t)!,
      primary400: Color.lerp(primary400, other.primary400, t)!,
      primary500: Color.lerp(primary500, other.primary500, t)!,
      primary600: Color.lerp(primary600, other.primary600, t)!,
      primary700: Color.lerp(primary700, other.primary700, t)!,
      primary800: Color.lerp(primary800, other.primary800, t)!,
      primary900: Color.lerp(primary900, other.primary900, t)!,
      primary950: Color.lerp(primary950, other.primary950, t)!,
      primary1000: Color.lerp(primary1000, other.primary1000, t)!,
      error0: Color.lerp(error0, other.error0, t)!,
      error25: Color.lerp(error25, other.error25, t)!,
      error50: Color.lerp(error50, other.error50, t)!,
      error75: Color.lerp(error75, other.error75, t)!,
      error100: Color.lerp(error100, other.error100, t)!,
      warning0: Color.lerp(warning0, other.warning0, t)!,
      warning25: Color.lerp(warning25, other.warning25, t)!,
      warning50: Color.lerp(warning50, other.warning50, t)!,
      warning75: Color.lerp(warning75, other.warning75, t)!,
      warning100: Color.lerp(warning100, other.warning100, t)!,
      success0: Color.lerp(success0, other.success0, t)!,
      success25: Color.lerp(success25, other.success25, t)!,
      success50: Color.lerp(success50, other.success50, t)!,
      success75: Color.lerp(success75, other.success75, t)!,
      success100: Color.lerp(success100, other.success100, t)!,
      grey0: Color.lerp(grey0, other.grey0, t)!,
      grey50: Color.lerp(grey50, other.grey50, t)!,
      grey100: Color.lerp(grey100, other.grey100, t)!,
      grey200: Color.lerp(grey200, other.grey200, t)!,
      grey300: Color.lerp(grey300, other.grey300, t)!,
      grey400: Color.lerp(grey400, other.grey400, t)!,
      grey500: Color.lerp(grey500, other.grey500, t)!,
      grey600: Color.lerp(grey600, other.grey600, t)!,
      grey700: Color.lerp(grey700, other.grey700, t)!,
      grey800: Color.lerp(grey800, other.grey800, t)!,
      grey900: Color.lerp(grey900, other.grey900, t)!,
      grey950: Color.lerp(grey950, other.grey950, t)!,
      grey1000: Color.lerp(grey1000, other.grey1000, t)!,
      linearTop: Color.lerp(linearTop, other.linearTop, t)!,
      linearBottom: Color.lerp(linearBottom, other.linearBottom, t)!,
    );
  }
}
