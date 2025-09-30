import 'package:aura_interiors/app/constant/colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.light(primary: AppColors.primary),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: Colors.black,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.dark(primary: AppColors.primary),
);
