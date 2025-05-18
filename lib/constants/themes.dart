import 'package:flutter/material.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'text_styles.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final TextStyles textStyles;

  const AppThemeExtension({required this.textStyles});

  @override
  AppThemeExtension copyWith({TextStyles? textStyles}) {
    return AppThemeExtension(textStyles: textStyles ?? this.textStyles);
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return this;
  }
}

final AppThemeExtension appThemeExtension = AppThemeExtension(
  textStyles: TextStyles(
    displayL: TextStyle(
      fontFamily: "DMSans",
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    displayM: TextStyle(
      fontFamily: "DMSans",
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    headingXL: TextStyle(
      fontFamily: "DMSans",
      fontSize: 32,
      fontWeight: FontWeight.w600,
    ),
    headingL: TextStyle(
      fontFamily: "DMSans",
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headingM: TextStyle(
      fontFamily: "DMSans",
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headingS: TextStyle(
      fontFamily: "DMSans",
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headingSMedium: TextStyle(fontFamily: "DMSans", fontSize: 16),
    headingXS: TextStyle(fontFamily: "DMSans", fontSize: 16),
    ctaL: TextStyle(fontFamily: "DMSans", fontSize: 16),
    ctaM: TextStyle(fontFamily: "DMSans", fontSize: 14),
    ctaS: TextStyle(fontFamily: "DMSans", fontSize: 12),
    paragraphL: TextStyle(
      fontFamily: "PlusJakartaSans",
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    paragraphM: TextStyle(
      fontFamily: "PlusJakartaSans",
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    paragraphS: TextStyle(
      fontFamily: "PlusJakartaSans",
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    paragraphXS: TextStyle(
      fontFamily: "PlusJakartaSans",
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    linkL: TextStyle(
      fontFamily: "DMSans",
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    linkM: TextStyle(
      fontFamily: "DMSans",
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    linkS: TextStyle(
      fontFamily: "DMSans",
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  ),
);

/// As said in the colors.dart file, I have just defined the light theme for this demo.

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryLight500,
  scaffoldBackgroundColor: AppColors.greyLight0,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryLight500,
    onPrimary: AppColors.primaryLight50,
    secondary: AppColors.successLight50,
    onSecondary: AppColors.successLight0,
    surface: AppColors.greyLight0,
    onSurface: AppColors.greyLight1000,
    error: AppColors.errorLight50,
    onError: AppColors.errorLight0,
  ),
  extensions: <ThemeExtension<dynamic>>[
    CustomPalette(
      primary50: AppColors.primaryLight50,
      primary100: AppColors.primaryLight100,
      primary200: AppColors.primaryLight200,
      primary300: AppColors.primaryLight300,
      primary400: AppColors.primaryLight400,
      primary500: AppColors.primaryLight500,
      primary600: AppColors.primaryLight600,
      primary700: AppColors.primaryLight700,
      primary800: AppColors.primaryLight800,
      primary900: AppColors.primaryLight900,
      primary950: AppColors.primaryLight950,
      primary1000: AppColors.primaryLight1000,
      error0: AppColors.errorLight0,
      error25: AppColors.errorLight25,
      error50: AppColors.errorLight50,
      error75: AppColors.errorLight75,
      error100: AppColors.errorLight100,
      warning0: AppColors.warningLight0,
      warning25: AppColors.warningLight25,
      warning50: AppColors.warningLight50,
      warning75: AppColors.warningLight75,
      warning100: AppColors.warningLight100,
      success0: AppColors.successLight0,
      success25: AppColors.successLight25,
      success50: AppColors.successLight50,
      success75: AppColors.successLight75,
      success100: AppColors.successLight100,
      grey0: AppColors.greyLight0,
      grey50: AppColors.greyLight50,
      grey100: AppColors.greyLight100,
      grey200: AppColors.greyLight200,
      grey300: AppColors.greyLight300,
      grey400: AppColors.greyLight400,
      grey500: AppColors.greyLight500,
      grey600: AppColors.greyLight600,
      grey700: AppColors.greyLight700,
      grey800: AppColors.greyLight800,
      grey900: AppColors.greyLight900,
      grey950: AppColors.greyLight950,
      grey1000: AppColors.greyLight1000,
      linearTop: AppColors.linearTop,
      linearBottom: AppColors.linearBottom,
    ),
    appThemeExtension,
  ],
);
