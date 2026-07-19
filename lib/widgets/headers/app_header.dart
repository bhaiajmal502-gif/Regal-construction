import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';

class AppHeader extends StatelessWidget {
  final String companyName;
  final String? greeting;
  final String? date;
  final VoidCallback? onProfileTap;
  final Widget? profileImage;

  const AppHeader({
    Key? key,
    required this.companyName,
    this.greeting,
    this.date,
    this.onProfileTap,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingMedium,
        vertical: AppSpacing.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (greeting != null)
                      Text(
                        greeting!,
                        style: AppTypography.bodySmall,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      companyName,
                      style: AppTypography.displaySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.premiumGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: profileImage ??
                      const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginLarge),
          if (date != null)
            Text(
              date!,
              style: AppTypography.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}
