import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB); // Deep Royal Blue
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color primaryLight = Color(0xFFDBEAFE);

  // Secondary
  static const Color secondary = Color(0xFF1E293B); // Dark Slate
  static const Color secondaryLight = Color(0xFF334155);

  // Accent
  static const Color accent = Color(0xFFF59E0B); // Construction Gold
  static const Color accentLight = Color(0xFFFEDC9B);

  // Background
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgLighter = Color(0xFFF1F5F9);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF16A34A); // Green
  static const Color warning = Color(0xFFF97316); // Orange
  static const Color error = Color(0xFFDC2626); // Red
  static const Color info = Color(0xFF0EA5E9); // Light Blue

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textLight = Color(0xFFD1D5DB);

  // Dark Mode Colors
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkBgSecondary = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);

  // Gradient Colors
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFFEA580C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppColorsLight {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;
  static const Color accent = AppColors.accent;
  static const Color background = AppColors.bgLight;
  static const Color surface = AppColors.cardBackground;
  static const Color error = AppColors.error;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = AppColors.textPrimary;
  static const Color onSurface = AppColors.textPrimary;
}

class AppColorsDark {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondaryLight;
  static const Color accent = AppColors.accent;
  static const Color background = AppColors.darkBg;
  static const Color surface = AppColors.darkCard;
  static const Color error = AppColors.error;
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = AppColors.darkTextPrimary;
  static const Color onSurface = AppColors.darkTextPrimary;
}