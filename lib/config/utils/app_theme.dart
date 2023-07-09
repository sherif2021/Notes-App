import 'package:clean_arch_example/config/utils/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      useMaterial3: true,
    );
