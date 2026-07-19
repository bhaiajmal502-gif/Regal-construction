import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Display Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 0,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  // Headline Styles
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineXSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.33,
    color: AppColors.textPrimary,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: AppColors.textSecondary,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.27,
    color: AppColors.textSecondary,
  );
}

class AppTypographyDark {
  static TextStyle displayLarge = AppTypography.displayLarge.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle displayMedium = AppTypography.displayMedium.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle displaySmall = AppTypography.displaySmall.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle headlineSmall = AppTypography.headlineSmall.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle headlineXSmall = AppTypography.headlineXSmall.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle titleLarge = AppTypography.titleLarge.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle titleMedium = AppTypography.titleMedium.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle titleSmall = AppTypography.titleSmall.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle bodyLarge = AppTypography.bodyLarge.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle bodyMedium = AppTypography.bodyMedium.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle bodySmall = AppTypography.bodySmall.copyWith(
    color: AppColors.darkTextSecondary,
  );

  static TextStyle labelLarge = AppTypography.labelLarge.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle labelMedium = AppTypography.labelMedium.copyWith(
    color: AppColors.darkTextPrimary,
  );

  static TextStyle labelSmall = AppTypography.labelSmall.copyWith(
    color: AppColors.darkTextSecondary,
  );
}