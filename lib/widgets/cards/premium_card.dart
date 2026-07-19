import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';

class PremiumCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final bool showArrow;

  const PremiumCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 2,
    this.padding,
    this.showArrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        splashColor: AppColors.primary.withOpacity(0.1),
        highlightColor: AppColors.primary.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: padding ??
              const EdgeInsets.all(AppSpacing.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.primary,
                      size: AppSpacing.iconLarge,
                    ),
                  ),
                  if (showArrow)
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textSecondary,
                      size: 16,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.marginMedium),
              Text(
                title,
                style: AppTypography.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...,
              const SizedBox(height: 4),
              Text(
                subtitle ?? '',
                style: AppTypography.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
